require_relative 'template'

class TemplateChangelog < Template
  def template_file
    'changelog.erb'
  end

  def output_file
    'CHANGELOG.md'
  end
end

