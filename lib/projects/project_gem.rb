require_relative 'project'
require_relative '../template_classes/template_gemfile_gem'
require_relative '../template_classes/template_gemspec'
require_relative '../template_classes/template_spec_test'
require_relative '../../lib/template_classes/template_spec_helper'

module Projects
  class ProjectGem < Project
    GEMS = [
        ['simplecov', '', '0.7.1']
    ]

    def initialize(project_name)
      super(project_name)
      @template_classes.concat([
                                   TemplateGemfileGem,
                                   TemplateGemspec,
                                   TemplateSpecTest,
                                   TemplateMain,
                                   TemplateTasks,
                                   TemplateSpecHelper
                               ]
      )
    end

    def generate_project
      super do
        FileUtils.mkdir_p(File.join(@project_name, 'spec', 'unit'))
      end
    end

    # TODO think about best way to handle gems
    def self.gems
      GEMS + Project::GEMS
    end
  end
end