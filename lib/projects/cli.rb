require 'fileutils'
require_relative 'gem'
require_relative '../template_classes/bin_cli'
require_relative '../template_classes/cmd_version'
require_relative '../template_classes/version'
require_relative '../template_classes/empty_dir'

module Projects
  class ProjectCLI < ProjectGem
    def initialize(proj_name, proj_domain)
      super(proj_name, :cli, proj_domain)

      runtime_gems.concat(
        [
          %w(thor ~> 0.19)
        ]
      )

      create_standard_templates([TemplateBinCli, TemplateCommandVersion, TemplateVersion])
      create_empty_dir_template('resources')
    end
  end
end
