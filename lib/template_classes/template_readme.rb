require_relative 'template'

class TemplateReadme < Template
  def initialize(project_name, module_name, template_data = {})
    super(project_name, module_name, template_data)
    validate_project_domain
  end

  def template_file
    'readme.erb'
  end

  def output_file
    'README.md'
  end

  private

  def validate_project_domain
    return if template_data[:project_domain]
    user_name = ENV['USER'].nil? ? '\<first_name-last_name\>' : ENV['USER'].gsub('.', '-')
    template_data[:project_domain] = user_name
  end
end
