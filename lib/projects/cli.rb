require 'fileutils'
require_relative 'gem'
require_relative '../template_classes/bin_cli'
require_relative '../template_classes/main'
require_relative '../template_classes/version'
require_relative '../template_classes/empty_dir'

module Projects
  class ProjectCLI < ProjectGem
    def initialize(proj_name, proj_domain)
      super(proj_name, :cli, proj_domain)
      create_standard_templates([TemplateBinCli, TemplateVersion])
      create_empty_dir_template('resources')
    end
  end
end
