require_relative 'base'
require_relative '../template_classes/changelog'
require_relative '../template_classes/gemfile_gem'
require_relative '../template_classes/gemspec'
require_relative '../template_classes/example_spec'
require_relative '../template_classes/main'
require_relative '../template_classes/rakefile_gem'
require_relative '../template_classes/readme'
require_relative '../template_classes/spec_helper'
require_relative '../template_classes/version'
require_relative '../template_classes/dot_gitignore_gem'
require_relative '../template_classes/config_yml'
require 'semver'

module Projects
  class ProjectGem < Project
    def initialize(proj_name, proj_type, proj_domain)
      super(proj_name, proj_type, proj_domain)

      dev_gems.concat(
        [
          %w(orb_configuration ~> 1.2)
        ]
      )

      runtime_gems.concat(
        [
          %w(orb_build_lifecycle ~> 2.1)
        ]
      )

      create_standard_templates(
        [
          TemplateDotGitignoreGem,
          TemplateGemfileGem,
          TemplateExampleSpec,
          TemplateMain,
          TemplateRakefileGem,
          TemplateReadme,
          TemplateSpecHelper,
          TemplateBuildShell,
          TemplateVersion,
          TemplateConfigYml,
          TemplateChangelog
        ]
      )

      # templates that require additional data
      version_path = TemplateVersion.new(project_name, module_name).gemspec_require_path
      templates << TemplateGemspec.new(project_name, module_name,
                                       dev_gems: dev_gems, runtime_gems: runtime_gems, version_path: version_path)
    end

    # Create a .semver file for gem projects.
    def post_install_actions
      Dir.chdir(@project_name) do
        SemVer.new.save(SemVer::FILE_NAME)
      end
    end
  end
end
