require 'fileutils'
require_relative 'app'
require_relative '../template_classes/tasks_test'
require_relative '../template_classes/build_shell_app'
require_relative '../template_classes/config_yml_test'

module Projects
  # This class should never be directly instantiated. Use ProjectTestGeneric or ProjectTestBertha
  # base test project class
  class ProjectTest < ProjectApp
    def initialize(proj_name, proj_domain)
      super(proj_name, :test, proj_domain)

      dev_gems.concat(
        [
          %w(orb_test_support ~> 3.1),
          %w(clean_config ~> 0.0.2)
        ]
      )

      create_standard_templates(
        [
          TemplateTasksTest,
          TemplateBuildShellApp,
          TemplateConfigYmlTest
        ]
      )
      acceptance_test_base_dir = File.join('spec', 'accept')

      %w(smoke sanity primary secondary).map do |test_type_dir|
        create_dummy_test_files(acceptance_test_base_dir, test_type_dir)
        # create_empty_dir_template(acceptance_test_base_dir, test_type_dir)
      end
      create_empty_dir_template('resources')
    end

    # TODO: this is only necessary right now because rspec has a bug open where it will run all the tests if the pattern
    # passed in does not retrieve any tests (https://github.com/rspec/rspec-core/issues/1126 and
    # https://github.com/rspec/rspec-core/pull/1589) so we are temporarily generating files rather than
    # empty directories until this is fixed
    def create_dummy_test_files(*path)
      templates << TemplateExampleSpec.new(project_name, module_name, test_directory: File.join(path))
    end
  end
end
