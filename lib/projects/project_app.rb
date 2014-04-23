require_relative 'project'
require_relative '../template_classes/template_gemfile_app'

module Projects
  class ProjectApp < Project

    def initialize(project_name)
      super(project_name)
      @template_classes.concat([TemplateGemfileApp])
    end

  end
end