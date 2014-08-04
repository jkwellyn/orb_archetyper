require_relative 'project_cli'
require_relative 'project_core'
require_relative 'project_utility'
require_relative 'project_test'
require_relative 'project_meta'
require_relative '../template_classes/template'

module Projects
  class ProjectFactory
    PROJECT_MAP = {
      cli: ProjectCLI,
      core: ProjectCore,
      meta: ProjectMeta,
      test: ProjectTest,
      utility: ProjectUtility
    }

    def self.make_project(project_type, project_name)
      PROJECT_MAP[project_type.to_sym].new(project_name.to_s)
    end
  end
end
