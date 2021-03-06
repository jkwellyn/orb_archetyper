require_relative 'test'
require_relative '../template_classes/spec_helper_test'
require_relative '../template_classes/example_spec'

module Projects
  class ProjectTestGeneric < ProjectTest
    def initialize(proj_name, proj_domain)
      super(proj_name, proj_domain)

      create_standard_templates([TemplateSpecHelperTest])
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
