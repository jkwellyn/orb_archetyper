require_relative 'project'
require_relative '../template_classes/template_gemfile_gem'
require_relative '../template_classes/template_gemspec'
require_relative '../template_classes/template_example_spec'
require_relative '../../lib/template_classes/template_rakefile'
require_relative '../../lib/template_classes/template_spec_helper'
require_relative '../template_classes/template_version'

module Projects
  class ProjectGem < Project

    def initialize(project_name)
      super(project_name)

      @gems.concat([['simplecov', '', '0.7.1']])

      create_standard_templates(
          [
              TemplateGemfileGem,
              TemplateExampleSpec,
              TemplateMain,
              TemplateTasks,
              TemplateRakefile,
              TemplateSpecHelper,
              TemplateBuildShell,
              TemplateVersion
          ]
      )

      # templates that require additional data
      version_path = TemplateVersionTopLevel.new(@project_name, @module_name).gemspec_require_path
      @templates << TemplateGemspec.new(@project_name,
                                        @module_name,
                                        { gems: @gems, version_path: version_path })
    end

    def generate_project
      super do
        FileUtils.mkdir_p(File.join(@project_name, 'spec', 'unit'))
      end
    end
  end
end
