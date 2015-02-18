require_relative 'project_cli'
require_relative 'project_core'
require_relative 'project_test_generic'
require_relative 'project_test_bertha'
require_relative 'project_meta'
require_relative '../template_classes/template'

module Projects
  InvalidProjectException = Class.new(Exception)

  class ProjectFactory
    PROJECT_MAP = {
      cli:         ProjectCLI,
      core:        ProjectCore,
      meta:        ProjectMeta,
      test:        ProjectTestGeneric,
      bertha_test: ProjectTestBertha
    }

    def self.make_project(proj_name, proj_type, proj_domain)
      project_class = PROJECT_MAP[proj_type.to_sym]

      unless project_class
        error_message = "Invalid project type '#{proj_type}'. You must specify one of #{PROJECT_MAP.keys.map(&:to_s)}."
        fail InvalidProjectException, error_message
      end

      project_class.new(proj_name.to_s, proj_domain)
    end
  end
end
