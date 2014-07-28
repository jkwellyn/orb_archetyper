require_relative 'project_gem'

module Projects
  class ProjectUtility < ProjectGem
    def initialize(project_name)
      super(project_name)

      create_empty_dir_template('config')
    end
  end
end
