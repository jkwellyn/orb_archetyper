require 'fileutils'
require_relative 'project_gem'
require_relative '../template_classes/template_bin_cli'
require_relative '../template_classes/template_main'
require_relative '../template_classes/template_version'

module Projects
  class ProjectCLI < ProjectGem

    def initialize(project_name)
      super(project_name)

      create_standard_templates([TemplateBinCli,
                                 TemplateVersion])
    end

    def generate_project
      super do
        FileUtils.mkdir_p(File.join(@project_name, 'resources'))
      end
    end
  end
end