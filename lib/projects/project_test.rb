require_relative 'project_app'
require 'fileutils'

module Projects
  class ProjectTest < ProjectApp

    def generate_project
      super do
        acceptance_test_base_dir = File.join(@project_name, 'spec', 'accept')
        additional_files = ['smoke', 'sanity', 'primary', 'secondary'].map do |test_type_dir|
          File.join(FileUtils.mkdir_p(File.join(acceptance_test_base_dir, test_type_dir)))
        end
        additional_files << File.join(FileUtils.mkdir_p(File.join(@project_name, 'resources')))
      end
    end

  end
end