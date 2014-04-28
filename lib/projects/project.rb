require 'ansi/code'
require 'fileutils'
require 'set'
require_relative '../template_classes/template_build_bash'
require_relative '../template_classes/template_dot_gitignore'
require_relative '../template_classes/template_dot_metrics'
require_relative '../template_classes/template_rakefile'
require_relative '../template_classes/template_readme'
require_relative '../template_classes/template_dot_rspec'
require_relative '../template_classes/template_tasks'
require_relative '../template_classes/template_spec_helper'
require_relative '../template_classes/template_version'
require_relative '../../lib/gems/gem_data'

module Projects
  class Project
    attr_reader :template_classes
    attr_reader :project_name
    attr_accessor :additional_templates
    attr_accessor :rejected_templates

    #TODO break the specifier into own element?
    GEMS = [
        %w{metric_fu ~> 4.8.0},
        %w{rake ~> 10.1.1},
        %w{rake-notes ~> 0.2.0},
        %w{rdoc > 2.4.2},
        %w{rspec 2.14.1},
        %w{rspec-extra-formatters 0.4},
        %w{rubocop 0.16.0},
        %w{simplecov 0.7.1},
        %w{fuubar 1.3.2},
    ]

    def initialize(project_name)
      @project_name = project_name
      @module_name = @project_name.split(/[_\-]/).map(&:capitalize).join
      @additional_templates = []
      @rejected_templates = []

      #TODO
      #Are we supposed to include rake tasks for a 'utility' project?
      #:rubocop? Not for all projects?
      #:rvmrc not included? Maybe to be included via switches?
      #:main? Double check who needs it.
      @template_classes = [
          TemplateBuildBash,
          TemplateDotGitignore,
          TemplateDotMetrics,
          TemplateRakefile,
          TemplateReadme,
          TemplateDotRspec,
          TemplateSpecHelper,
          TemplateVersion
      ]
    end

    def generate_project
      checked_generate_project do
        make_template_set.each do |template_class|
          generate_file_with_output do
            template = template_class.new(@project_name, @module_name)
            output_directory = File.join(FileUtils.mkdir_p(template.output_directory))
            full_path = File.join(output_directory, template.output_file)
            File.write(full_path, template.render)
            template.post_install_actions(full_path)
            full_path
          end
        end

        if block_given?
          Array(yield).each {|additional_file| generate_file_with_output{additional_file}}
        end

      end
    end

    def generate_file_with_output
      puts "\t" + ANSI.green{"created"} + " #{yield}"
    end

    private

    def make_template_set
      Set.new(@template_classes - @rejected_templates + @additional_templates)
    end

    def checked_generate_project
      raise "Error. Directory already exists: #{@project_name}" if Dir.exists?(@project_name)
      yield
    end

  end
end
