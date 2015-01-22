require_relative 'project'
require_relative '../template_classes/template_gemfile_gem'
require_relative '../template_classes/template_gemspec'
require_relative '../template_classes/template_example_spec'
require_relative '../template_classes/template_main'
require_relative '../template_classes/template_rakefile_gem'
require_relative '../template_classes/template_spec_helper'
require_relative '../template_classes/template_version'
require_relative '../template_classes/template_dot_gitignore_gem'

module Projects
  class ProjectGem < Project
    def initialize(project_name, project_type, project_domain)
      super(project_name, project_type, project_domain)

      @dev_gems.concat(
        [
          %w(build_lifecycle ~> 0.0.6)
        ]
      )

      create_standard_templates(
        [
          TemplateDotGitignoreGem,
          TemplateGemfileGem,
          TemplateExampleSpec,
          TemplateMain,
          TemplateRakefileGem,
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
