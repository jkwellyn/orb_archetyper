require_relative 'project'
require_relative '../template_classes/template_gemfile_gem'
require_relative '../template_classes/template_gemspec'
require_relative '../template_classes/template_spec_test'

module Projects
  class ProjectGem < Project

    def initialize(project_name)
      super(project_name)
      @template_classes.concat([TemplateGemfileGem, TemplateGemspec, TemplateSpecTest, TemplateMain, TemplateTasks,])
    end

    def generate_project
      super do
        FileUtils.mkdir_p(File.join(@project_name, 'spec', 'unit'))
      end
    end
  end
end