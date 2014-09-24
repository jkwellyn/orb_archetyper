require_relative 'project'
require_relative '../template_classes/template_version_top_level'
require_relative '../../lib/template_classes/template_rakefile_meta'

module Projects
  class ProjectMeta < Project
    def initialize(project_name)
      super(project_name)

      @dev_gems = [
        %w(rake ~> 10.1.1),
        %w(yard ~> 0.8.7)
      ] # rely on sub projects to set the gems

      create_standard_templates([TemplateGemfileGem,
                                 TemplateVersionTopLevel,
                                 TemplateRakefileMeta,
                                 TemplateChangelog])

      # templates that require additional data
      version_path = TemplateVersionTopLevel.new(@project_name, @module_name).gemspec_require_path
      @templates << TemplateGemspec.new(@project_name, @module_name,
                                        dev_gems: @dev_gems, runtime_gems: @runtime_gems, version_path: version_path)
    end
  end
end
