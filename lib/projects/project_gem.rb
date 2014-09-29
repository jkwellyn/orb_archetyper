require_relative 'project'
require_relative '../template_classes/template_gemfile_gem'
require_relative '../template_classes/template_gemspec'
require_relative '../template_classes/template_example_spec'
require_relative '../../lib/template_classes/template_rakefile'
require_relative '../../lib/template_classes/template_spec_helper'
require_relative '../template_classes/template_version'

module Projects
  class ProjectGem < Project
    def initialize(project_name, project_type)
      super(project_name, project_type)

      @dev_gems.concat([['simplecov', '', '0.7.1']])

      create_standard_templates(
        [
          TemplateGemfileGem,
          TemplateExampleSpec,
          TemplateMain,
          TemplateTasks,
          TemplateRakefile,
          TemplateSpecHelper,
          TemplateBuildShell,
          TemplateVersion,
          TemplateDotRubocopYml,
          TemplateChangelog
        ]
      )

      # templates that require additional data
      version_path = TemplateVersion.new(@project_name, @module_name).gemspec_require_path
      @templates << TemplateGemspec.new(@project_name, @module_name,
                                        dev_gems: @dev_gems, runtime_gems: @runtime_gems, version_path: version_path)
    end
  end
end
