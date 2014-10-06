require_relative 'project_gem'
require_relative '../template_classes/template_config_yml'

module Projects
  class ProjectUtility < ProjectGem
    def initialize(project_name)
      super(project_name, :utility)

      @dev_gems.concat([%w(orb_configuration ~> yay1.0)])

      create_standard_templates([TemplateConfigYml])
    end
  end
end
