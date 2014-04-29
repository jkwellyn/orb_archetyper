require_relative 'template_spec_test'

class TemplateSmokeTest < TemplateSpecTest

  def output_directory
    File.join(@project_name, %w{spec accept smoke})
  end

  def require_spec_helper
    File.join('..', '..', 'spec_helper')
  end
end