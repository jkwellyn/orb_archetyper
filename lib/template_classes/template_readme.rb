require_relative 'template'

class TemplateReadme < Template

  def template_file
    'readme.erb'
  end

  def output_file
    'README.md'
  end

end