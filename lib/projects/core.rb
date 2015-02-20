require_relative 'gem'

module Projects
  class ProjectCore < ProjectGem
    def initialize(proj_name, proj_domain)
      super(proj_name, :core, proj_domain)
    end
  end
end
