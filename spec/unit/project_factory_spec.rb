require_relative '../../lib/projects/project_factory'
require_relative '../../lib/template_classes/bin_cli'
require_relative '../../lib/template_classes/license'
require_relative '../../lib/template_classes/version'

module Projects
  describe ProjectFactory do
    context 'Project Creation' do

      ProjectFactory::PROJECT_MAP.each do |project_type, project_class|
        expected_project_name = 'rpsec-test-project'

        it "creates #{project_type} projects correctly" do
          project = ProjectFactory.make_project(
              expected_project_name,
              project_type,
              'opower'
          )
          expect(project.class).to be project_class
          expect(project.project_name).to be expected_project_name
        end

        it 'throws useful exception on bad project type' do
          expect do
            ProjectFactory.make_project('foo', 'foo', 'opower')
          end.to raise_error
        end
      end
    end
  end
end
