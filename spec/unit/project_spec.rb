module Projects
  describe Project do
    context 'Generic Project' do
      subject(:project) { Project.new('project_name') }

      it { expect(project.project_name) == 'project_name' }
      it { expect(project.dev_gems).not_to be_empty }
      it { expect(project.templates).not_to be_empty }

      it 'should create generic templates from class names' do
        project.create_standard_templates([TemplateRakefile])
        expect(project.templates).to include(TemplateRakefile.new('project_name', 'ProjectName'))
      end

      it 'should create empty directory templates from paths' do
        project.create_empty_dir_template('monkey', 'chicken', 'turkey')
        expect(project.templates).to include(TemplateEmptyDir.new('project_name', 'ProjectName',
                                                                  directory_name: 'monkey/chicken/turkey'))
      end
    end

    # Not going to test all project sub-classes, arbitrary chose Gem project to test it's constructor
    context 'Gem Project' do
      subject(:project) { ProjectGem.new('project_gem') }

      # just checking a few templates, not bothering with all of them
      it 'should include the additional templates gems have' do
        expect(project.templates).to include(TemplateGemfileGem.new('project_gem', 'ProjectGem'))
        expect(project.templates).to include(TemplateVersion.new('project_gem', 'ProjectGem'))
      end

      it 'should populate the gemspec template with the appropriate path to the version file' do
        expected_template = TemplateGemspec.new('project_gem', 'ProjectGem',
                                                dev_gems: project.dev_gems, runtime_gems: project.runtime_gems,
                                                version_path: '../lib/project_gem/version')

        expect(project.templates).to include(expected_template)
      end
    end
  end
end
