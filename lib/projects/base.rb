require 'ansi/code'
require 'fileutils'
require 'set'
require 'orb_logger'
require_relative '../template_classes/build_shell'
require_relative '../template_classes/ci_metadata'
require_relative '../template_classes/changelog'
require_relative '../template_classes/rakefile'
require_relative '../template_classes/dot_rspec'
require_relative '../template_classes/dot_rubocop_yml'
require_relative '../template_classes/empty_dir'
require_relative '../template_classes/spec_helper'
require_relative '../template_classes/orb_annotations_mustache'
require_relative '../gems/gem_data'

module Projects
  # base project class
  class Project
    attr_accessor :dev_gems, :runtime_gems, :logger
    attr_accessor :module_name, :project_name, :project_type, :templates

    def initialize(proj_name, proj_type, _proj_domain)
      @project_name = proj_name
      @project_type = proj_type
      @module_name  = @project_name.split(/[_\-]/).map(&:capitalize).join
      @templates = []
      @logger = OrbLogger::OrbLogger.new
      @logger.progname = self.class.name

      # TODO: Are we supposed to include rake tasks for a 'utility' project?
      # :rubocop? Not for all projects?
      # :rvmrc not included? Maybe to be included via switches?
      # :main? Double check who needs it.

      create_standard_templates([TemplateDotRspec, TemplateOrbAnnotationsMustache])
      @templates << TemplateArchetyperMetadata.new(@project_name, @module_name, project_type: @project_type)

      # TODO: break the specifier into own element?
      @dev_gems = []
      @runtime_gems = [
        %w(orb_logger ~> 1.0)
      ]
    end

    # generate templates that don't require additional data
    def create_standard_templates(a_templates)
      a_templates.each do |template_class|
        templates << template_class.new(project_name, module_name)
      end
    end

    def create_empty_dir_template(*paths)
      templates << TemplateEmptyDir.new(project_name, module_name, directory_name: File.join(*paths))
    end

    def generate_project
      checked_generate_project do
        make_template_set.each do |template|
          generate_file_with_output do
            template.create
          end
        end

        Array(yield).each { |additional_file| generate_file_with_output { additional_file } } if block_given?
      end
    end

    def generate_file_with_output
      logger.info "#{ANSI.green { 'created' }} #{yield}"
    end

    private

    def make_template_set
      Set.new(templates)
    end

    def checked_generate_project
      fail "Error. Directory already exists: #{project_name}" if Dir.exist?(project_name)
      yield
    end
  end
end
