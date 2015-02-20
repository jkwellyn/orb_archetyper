require_relative 'cli'
require_relative 'core'
require_relative 'test_generic'
require_relative 'test_bertha'
require_relative '../template_classes/base'

module Projects
  InvalidProjectException = Class.new(Exception)

  class ProjectFactory
    PROJECT_MAP = {
      bertha_test: ProjectTestBertha,
      cli:         ProjectCLI,
      core:        ProjectCore,
      test:        ProjectTestGeneric
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
