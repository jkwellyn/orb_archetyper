require 'fileutils'
require_relative 'project_gem'
require_relative '../template_classes/template_bin_cli'
require_relative '../template_classes/template_main'

module Projects
  class ProjectCLI < ProjectGem

    def initialize(project_name)
      super(project_name)
      @template_classes.concat([TemplateBinCli])
    end

    def generate_project
      super do
        FileUtils.mkdir_p(File.join(@project_name, 'resources'))
      end
    end

  end
end