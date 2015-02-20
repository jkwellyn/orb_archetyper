require_relative 'project'
require_relative '../template_classes/template_gemfile_gem'
require_relative '../template_classes/template_gemspec'
require_relative '../template_classes/template_example_spec'
require_relative '../template_classes/template_main'
require_relative '../template_classes/template_rakefile_gem'
require_relative '../template_classes/template_readme'
require_relative '../template_classes/template_spec_helper'
require_relative '../template_classes/template_version'
require_relative '../template_classes/template_dot_gitignore_gem'
require_relative '../template_classes/template_config_yml'

module Projects
  class ProjectGem < Project
    def initialize(proj_name, proj_type, proj_domain)
      super(proj_name, proj_type, proj_domain)

      dev_gems.concat(
        [
          %w(build_lifecycle ~> 1.0),
          %w(orb_configuration ~> 1.0)
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
          TemplateChangelog,
          TemplateConfigYml
        ]
      )

      # templates that require additional data
      version_path = TemplateVersion.new(project_name, module_name).gemspec_require_path
      templates << TemplateGemspec.new(project_name, module_name,
                                       dev_gems: dev_gems, runtime_gems: runtime_gems, version_path: version_path)
      templates << TemplateReadme.new(project_name, module_name, project_domain: proj_domain)
    end
  end
end
