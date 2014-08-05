require_relative '../../lib/projects/project_factory'
require_relative '../../lib/template_classes/template_bin_cli'
require_relative '../../lib/template_classes/template_license'
require_relative '../../lib/template_classes/template_version'

module Projects
  describe ProjectFactory do
    context 'Project Creation' do

      ProjectFactory::PROJECT_MAP.each do |project_type, project_class|
        expected_project_name = 'rpsec-test-project'

        it "should create #{project_type} projects correctly" do
          project = ProjectFactory.make_project(
              project_type,
              expected_project_name
          )
          expect(project.class).to be project_class
          expect(project.project_name).to be expected_project_name
        end
      end
    end
  end
end
