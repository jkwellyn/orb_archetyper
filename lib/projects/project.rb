require 'ansi/code'
require 'fileutils'
require 'set'
require_relative '../template_classes/template_build_shell'
require_relative '../template_classes/template_dot_gitignore'
require_relative '../template_classes/template_rakefile'
require_relative '../template_classes/template_readme'
require_relative '../template_classes/template_dot_rspec'
require_relative '../template_classes/template_tasks'
require_relative '../template_classes/template_spec_helper'
require_relative '../template_classes/template_orb_annotations_mustache'
require_relative '../../lib/gems/gem_data'

module Projects
  class Project
    attr_accessor :gems
    attr_reader :templates
    attr_reader :project_name
    attr_accessor :additional_templates
    attr_accessor :rejected_templates
    attr_accessor :additional_directories

    def initialize(project_name)
      @project_name = project_name
      @module_name = @project_name.split(/[_\-]/).map(&:capitalize).join
      @additional_templates = []
      @rejected_templates = []
      @templates = []

      #TODO
      #Are we supposed to include rake tasks for a 'utility' project?
      #:rubocop? Not for all projects?
      #:rvmrc not included? Maybe to be included via switches?
      #:main? Double check who needs it.

      create_standard_templates([TemplateDotGitignore,
                                 TemplateReadme,
                                 TemplateDotRspec,
                                 TemplateOrbAnnotationsMustache])

      #TODO break the specifier into own element?
      @gems = [
        ['rake', '~>', '10.1.1'],
        ['annotation_manager', '~>', '0.0.2'],
        ['yard', '~>', '0.8.7'],
        ['redcarpet', '~>', '2.3.0'],
        ['rspec', '', '2.14.1'],
        ['rspec-extra-formatters', '', '0.4'],
        ['rubocop', '',  '0.16.0'],
        ['fuubar', '', '1.3.2'],
        ['opower-deployment']
      ]
    end

    # generate templates that don't require additional data
    def create_standard_templates(templates)
      templates.each do |template_class|
        @templates << template_class.new(@project_name, @module_name)
      end
    end

    def create_empty_dir_template(*paths)
      @templates << TemplateEmptyDir.new(@project_name, @module_name, {directory_name: File.join(*paths)})
    end

    def generate_project
      checked_generate_project do
        make_template_set.each do |template|
          generate_file_with_output do
            template.create
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
      Set.new(@templates - @rejected_templates + @additional_templates)
    end

    def checked_generate_project
      raise "Error. Directory already exists: #{@project_name}" if Dir.exists?(@project_name)
      yield
    end

  end
end
