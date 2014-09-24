require_relative 'project'
require_relative '../template_classes/template_gemfile_app'
require_relative '../../lib/template_classes/template_rakefile'
require_relative '../template_classes/template_version_top_level'

module Projects
  class ProjectApp < Project
    def initialize(project_name)
      super(project_name)

      create_standard_templates([TemplateRakefile,
                                 TemplateVersionTopLevel,
                                 TemplateDotRubocopYml,
                                 TemplateChangelog])

      # templates that require additional data
      @templates << TemplateGemfileApp.new(@project_name, @module_name, dev_gems: @dev_gems, runtime_gems: @runtime_gems)
    end
  end
end
