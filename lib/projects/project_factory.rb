require_relative 'project_cli'
require_relative 'project_core'
require_relative 'project_utility'
require_relative 'project_test_generic'
require_relative 'project_test_bertha'
require_relative 'project_meta'
require_relative '../template_classes/template'

module Projects
  class InvalidProjectException < Exception
  end

  class ProjectFactory
    PROJECT_MAP = {
      cli: ProjectCLI,
      core: ProjectCore,
      meta: ProjectMeta,
      test: ProjectTestGeneric,
      utility: ProjectUtility,
      bertha_test: ProjectTestBertha
    }

    def self.make_project(project_type, project_name)
      project_class = PROJECT_MAP[project_type.to_sym]

      if project_class.nil?
        error_message = "#{project_type} is an invalid project type. You must specify one of #{PROJECT_MAP.keys.map(&:to_s)}."
        fail(InvalidProjectException, error_message)
      end

      project_class.new(project_name.to_s)
    end
  end
end
