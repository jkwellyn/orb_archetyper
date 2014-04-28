require_relative 'project_app'
require_relative '../../lib/template_classes/template_tasks_test'
require 'fileutils'

module Projects
  class ProjectTest < ProjectApp

    def initialize(project_name)
      super(project_name)
      @template_classes.concat([TemplateTasksTest])
    end

    def generate_project
      super do
        acceptance_test_base_dir = File.join(@project_name, 'spec', 'accept')
        additional_files = %w{smoke sanity primary secondary}.map do |test_type_dir|
          File.join(FileUtils.mkdir_p(File.join(acceptance_test_base_dir, test_type_dir)))
        end
        additional_files << File.join(FileUtils.mkdir_p(File.join(@project_name, 'resources')))
      end
    end

  end
end