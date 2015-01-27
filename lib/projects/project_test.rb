require 'fileutils'
require_relative 'project_app'
require_relative '../template_classes/template_tasks_test'
require_relative '../template_classes/template_build_shell_app'
require_relative '../template_classes/template_dot_ruby_version'
require_relative '../template_classes/template_config_yml_test'

module Projects
  # This class should never be directly instantiated. Use ProjectTestGeneric or ProjectTestBertha
  # base test project class
  class ProjectTest < ProjectApp
    def initialize(proj_name, proj_domain)
      super(proj_name, :test, proj_domain)

      dev_gems.concat(
        [
          %w(test_support ~> 3.0),
          %w(orb_configuration ~> 1.0.4)
        ]
      )

      create_standard_templates(
        [
          TemplateTasksTest,
          TemplateBuildShellApp,
          TemplateDotRubyVersion,
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
