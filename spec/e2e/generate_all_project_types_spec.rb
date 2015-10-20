require_relative '../../lib/orb_archetyper/archetype_generator'
require_relative '../../lib/projects/test'
require_relative '../../lib/orb_archetyper/rules/naming_conventions/file_names'
require_relative 'e2e_spec_helper'

RSpec.configure do |config|
  config.include E2EHelper
end

module Projects
  describe ProjectFactory do
    include_context 'in sandbox directory'
    ProjectFactory::PROJECT_MAP.keys.each do |project_type|
      project_type = project_type.to_s

      # TODO: break this up into multiple 'it' statements
      it "generates a #{project_type} project correctly" do
        LOG.info "running generation for #{project_type}"
        options = {
          project: "test-project-#{project_type}",
          type: project_type,
          no_github: true
        }

        generator = ArchetypeGenerator.new(options[:project])
        generator.generate(options)
        project_name = generator.project_name

        expect_path_to_exist(true, project_name)
        expect_path_to_exist(true, project_name, '.git')

        project_test_expectations(project_type) do
          expected_spec_accept_path = File.join(project_name, 'spec', 'accept')
          expect_path_to_exist(true, expected_spec_accept_path, 'smoke')
          expect_path_to_exist(true, expected_spec_accept_path, 'sanity')
          expect_path_to_exist(true, expected_spec_accept_path, 'primary')
          expect_path_to_exist(true, expected_spec_accept_path, 'secondary')
          expect_path_to_exist(true, project_name, 'Gemfile')
          expect_path_to_exist(true, project_name, 'build.sh')
          expect_path_to_exist(true, project_name, '.ruby-version')
        end

        project_gem_expectations(project_type) do
          expected_file_name = "#{project_name}.rb"
          expect_path_to_exist(true, project_name, '.semver')
          expect_path_to_exist(true, project_name, 'lib', expected_file_name)
          expect_path_to_exist(true, project_name, 'build.sh')
          expect_path_to_exist(true, project_name, 'CHANGELOG.md')
          expect_path_to_exist(true, project_name, 'config')
        end

        # make sure generated projects work
        Dir.chdir(project_name) do
          # need to commit directory in order for git ls-files to work
          github_project = SharedTasks::OrbGithubProject::RepositoryGitLocal.new
          github_project.add_all
          github_project.commit('initial commit')
          script_output = ''
          Bundler.with_clean_env do
            script_output = `unset RELEASE; export RUBY_VERSIONS=1.9.3-p392 && ./build.sh`
          end
          LOG.info(script_output)
          expect($CHILD_STATUS.success?).to be true
        end
      end
    end

    def project_test_expectations(project_type)
      return unless project_type == 'test'
      yield
    end

    def project_gem_expectations(project_type)
      return unless project_type == 'core'
      yield
    end
  end
end
