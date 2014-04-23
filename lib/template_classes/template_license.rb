require_relative 'template'

class TemplateLicense < Template

  def template_file
    'license.erb'
  end

  def output_file
    'LICENSE'
  end
end