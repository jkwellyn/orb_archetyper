require_relative '../../lib/archetype_generator'
require_relative '../../lib/orb-archetyper/log/orb_logger'

module OrbArchetyper

  describe ArchetypeGenerator do

    before(:all) do
      log = Log::OrbLogger.new.logger
      log.info("called in: " + self.class.name + "," + File.basename(__FILE__))
    end

    context "Initialization" do
      it "generator is initilaized as expected" do

        generator = ArchetypeGenerator.new("project_a")
        expect(generator.project_name).to eq("project_a")
        expect(generator.module_name).to eq("ProjectA")

      end
    end

    context '#generate' do
      context 'uploads generated project to an organization' do
        let(:options){ { type: 'cli', project: 'my_project', upload_organization: 'auto' } }
        let(:generator){ ArchetypeGenerator.new(options[:project])}
        let(:project) {
          double('Projects::ProjectCli', { generate_project: {} }) }
        let(:project_github) {
          double('SharedTasks::GithubProject::Project',
                 {
                   commit_current_directory: {},
                   create_remote_repository: {},
                   push: {},
                   fork_repository: {}
                 }
          )
        }
        it 'generates a project' do
          Projects::ProjectFactory.stub(:make_project){ project }
          expect(project).to receive(:generate_project)

          SharedTasks::GithubProject::Project.stub(:initialize_git)
          SharedTasks::GithubProject::Project.stub(:new){ project_github }
          Dir.stub(:chdir) do |&block|
            block.call
          end

          expect(project_github).to receive(:commit_current_directory)
          expect(project_github).to receive(:create_remote_repository)
          expect(project_github).to receive(:push)
          expect(project_github).to receive(:fork_repository)

          generator.generate(options)
        end
      end
    end

    context 'Sanitize' do

      def expect_invalid_length_error(project_name)
        expect{ArchetypeGenerator.new(project_name)}.to raise_error ArchetypeGenerator::PROJECT_NAME_INVALID_LENGTH_ERROR
      end

      def expect_invalid_characters_error(project_name)
        expect{ArchetypeGenerator.new(project_name)}.to raise_error ArchetypeGenerator::PROJECT_NAME_INVALID_CHARACTERS_ERROR
      end

      it 'Correctly handles incorrect length=1' do
        expect_invalid_length_error('a')
      end

      it 'Correctly handles incorrect length=0' do
        expect_invalid_length_error('')
      end

      it 'Correctly handles incorrect nil' do
        expect_invalid_length_error(nil)
      end

      it "Correctly handles incorrect length > #{ArchetypeGenerator::PROJECT_NAME_MAX_LENGTH}" do
        invalid_project_name = 'a'
        ArchetypeGenerator::PROJECT_NAME_MAX_LENGTH.times.each{ invalid_project_name += 'a'}
        expect_invalid_length_error(invalid_project_name)
      end

      it 'Correctly handles invalid project names' do
        expect_invalid_characters_error('aaaa+')
      end

      it 'Correctly handles invalid project names' do
        expect_invalid_characters_error('aa//aa')
      end

      it 'Correctly handles invalid project names' do
        expect_invalid_characters_error('aa%%^^&&aa')
      end

      it 'Correctly handles invalid project names' do
        expect_invalid_characters_error('aa %%^ ^&&a a')
      end
    end
  end
end