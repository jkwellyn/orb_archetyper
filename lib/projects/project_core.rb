require_relative 'project_gem'

module Projects
  class ProjectCore < ProjectGem
    def initialize(project_name)
      super(project_name, :core)
    end
  end
end
