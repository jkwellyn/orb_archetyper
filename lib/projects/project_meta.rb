require_relative 'project'
require_relative '../template_classes/template_version_top_level'
require_relative '../../lib/template_classes/template_rakefile_meta'
require_relative '../template_classes/template_build_shell_meta'

module Projects
  class ProjectMeta < Project
    def initialize(proj_name, proj_domain)
      super(proj_name, :meta, proj_domain)

      dev_gems = [
        %w(rake ~> 10.1),
        %w(yard ~> 0.8),
        %w(opower-deployment = 0.1.2)
      ] # rely on sub projects to set the gems

      create_standard_templates(
        [
          TemplateGemfileGem,
          TemplateVersionTopLevel,
          TemplateRakefileMeta,
          TemplateBuildShellMeta,
          TemplateChangelog
        ]
      )

      # templates that require additional data
      version_path = TemplateVersionTopLevel.new(project_name, module_name).gemspec_require_path
      @templates  << TemplateGemspec.new(project_name, module_name,
                                         dev_gems: dev_gems, runtime_gems: runtime_gems, version_path: version_path)
    end
  end
end
