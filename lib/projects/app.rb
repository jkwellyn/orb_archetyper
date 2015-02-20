require_relative 'base'
require_relative '../template_classes/gemfile_app'
require_relative '../template_classes/rakefile'
require_relative '../template_classes/readme_test'
require_relative '../template_classes/version_top_level'
require_relative '../template_classes/dot_gitignore_app'

module Projects
  class ProjectApp < Project
    def initialize(proj_name, proj_type, proj_domain)
      super(proj_name, proj_type, proj_domain)

      dev_gems.concat(
        [
          %w(rake ~> 10.1),
          %w(annotation_manager ~> 1.0),
          %w(yard ~> 0.8),
          %w(redcarpet ~> 2.3),
          %w(rubocop = 0.26.1)
        ]
      )

      create_standard_templates(
        [
          TemplateDotGitignoreApp,
          TemplateRakefile,
          TemplateVersionTopLevel,
          TemplateDotRubocopYml,
          TemplateChangelog
        ]
      )

      # templates that require additional data
      templates << TemplateGemfileApp.new(project_name, module_name, dev_gems: dev_gems, runtime_gems: runtime_gems)
      templates << TemplateReadmeTest.new(project_name, module_name, project_domain: proj_domain)
    end
  end
end
