require 'fileutils'
require_relative 'project_gem'
require_relative '../template_classes/template_bin_cli'
require_relative '../template_classes/template_main'
require_relative '../template_classes/template_version'
require_relative '../template_classes/template_empty_dir'

module Projects
  class ProjectCLI < ProjectGem
    def initialize(project_name)
      super(project_name, :cli)
      create_standard_templates([TemplateBinCli,
                                 TemplateVersion])
      create_empty_dir_template('resources')
    end
  end
end
