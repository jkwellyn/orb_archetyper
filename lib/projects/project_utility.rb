require_relative 'project_gem'
require_relative '../template_classes/template_config_yml'

module Projects
  class ProjectUtility < ProjectGem
    def initialize(proj_name, proj_domain)
      super(proj_name, :utility, proj_domain)

      dev_gems.concat([%w(orb_configuration ~> 1.0)])

      create_standard_templates([TemplateConfigYml])
    end
  end
end
