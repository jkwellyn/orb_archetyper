require_relative 'project_test'
require_relative '../template_classes/template_bertha_job_config'
require_relative '../template_classes/template_spec_helper_bertha'
require_relative '../template_classes/template_example_spec_bertha'

module Projects
  class ProjectTestBertha < ProjectTest
    def initialize(proj_name, proj_domain)
      super(proj_name, proj_domain)

      dev_gems.concat(
        [
          %w(bertha_common ~> 0.1),
          %w(bertha_test_launcher ~> 0.0.2)
        ]
      )

      create_standard_templates([TemplateBerthaJobConfigYml, TemplateSpecHelperBertha])
    end

    # Override to place Bertha spec template
    def create_dummy_test_files(*path)
      templates << TemplateExampleSpecBertha.new(project_name, module_name, test_directory: File.join(path))
    end
  end
end
