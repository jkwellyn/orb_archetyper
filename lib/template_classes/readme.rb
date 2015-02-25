require_relative 'base'

class TemplateReadme < Template
  def initialize(project_name, module_name, template_data = {})
    super(project_name, module_name, template_data)
  end

  def template_file
    'readme.erb'
  end

  def output_file
    'README.md'
  end
end
