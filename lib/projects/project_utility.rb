require_relative 'project_gem'
require_relative '../template_classes/template_config_yml'

module Projects
  class ProjectUtility < ProjectGem
    def initialize(project_name)
      super(project_name)

      @gems.concat([['orb_configuration', '', '0.0.1']])

      create_standard_templates([TemplateConfigYml])
    end
  end
end
