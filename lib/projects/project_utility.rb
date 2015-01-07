require_relative 'project_gem'
require_relative '../template_classes/template_config_yml'

module Projects
  class ProjectUtility < ProjectGem
    def initialize(project_name, project_domain)
      super(project_name, :utility, project_domain)

      @dev_gems.concat([%w(orb_configuration ~> 1.0)])

      create_standard_templates([TemplateConfigYml])
    end
  end
end
