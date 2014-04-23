require_relative 'project_cli'
require_relative 'project_core'
require_relative 'project_utility'
require_relative 'project_test'
require_relative '../template_classes/template'

module Projects
  class ProjectFactory
    PROJECT_MAP = {
        cli: ProjectCLI,
        core: ProjectCore,
        test: ProjectTest,
        utility: ProjectUtility
    }

    def self.make_project(project_type, project_name, additional_templates = [], rejected_templates = [])
      project = PROJECT_MAP[project_type.to_sym].new(project_name.to_s)

      project.additional_templates = Array(additional_templates).map do |template|
        Template.convert_to_templates_class(template)
      end

      project.rejected_templates = Array(rejected_templates).map do |template|
        Template.convert_to_templates_class(template)
      end

      project
    end
  end
end
