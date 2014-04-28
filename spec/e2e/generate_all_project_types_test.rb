require_relative '../../lib/archetype_generator'
require_relative '../../lib/projects/project_test'
require_relative '../../lib/orb-archetyper/rules/naming_conventions/file_names'
require_relative 'e2e_spec_helper'

RSpec.configure do |config|
  config.include E2EHelper
end

module Projects
  describe ProjectTest do
    include_context 'in sandbox directory'

    ProjectFactory::PROJECT_MAP.keys.each do |project_type|
      project_type = project_type.to_s

      #TODO break this up into multiple 'it' statements
      it "should generate a #{project_type} project correctly" do

        options = {
            project: "test-project-#{project_type}",
            type: project_type,
            include: ['bin_cli'],
            exclude: ['gemfile_app'], #gemfile_app only applies to non-gem projects, like test
            github: true
        }

        generator = ArchetypeGenerator.new(options[:project])
        generator.generate(options)
        project_name = generator.project_name

        expect_path_to_exist(true, project_name)
        expect_path_to_exist(true, project_name, 'bin', project_name)
        expect_path_to_exist(true, project_name, '.git')

        project_test_expectations(project_type) do
          expected_spec_accept_path = File.join(project_name, 'spec', 'accept')
          expect_path_to_exist(true, expected_spec_accept_path, 'smoke')
          expect_path_to_exist(true, expected_spec_accept_path, 'sanity')
          expect_path_to_exist(true, expected_spec_accept_path, 'primary')
          expect_path_to_exist(true, expected_spec_accept_path, 'secondary')
          expect_path_to_exist(false, project_name, 'Gemfile')
        end

        project_gem_expectations(project_type) do
          expected_file_name = "#{project_name}.rb"
          expect_path_to_exist(true, project_name, 'lib', expected_file_name)
        end
      end
    end

    def project_test_expectations(project_type)
      if project_type == 'test'
        yield
      end
    end

    def project_gem_expectations(project_type)
      if project_type != 'test'
        yield
      end
    end
  end
end