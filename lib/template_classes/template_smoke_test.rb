require_relative 'template_example_spec'

class TemplateSmokeTest < TemplateExampleSpec

  def output_directory
    File.join(@project_name, %w{spec accept smoke})
  end

  def require_spec_helper
    File.join('..', '..', 'spec_helper')
  end
end