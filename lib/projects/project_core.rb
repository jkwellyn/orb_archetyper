require_relative 'project_gem'

module Projects
  class ProjectCore < ProjectGem
    def initialize(project_name, project_domain)
      super(project_name, :core, project_domain)
    end
  end
end
