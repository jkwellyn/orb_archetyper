require_relative 'base'

class TemplateLicense < Template
  def template_file
    'license.erb'
  end

  def output_file
    'LICENSE'
  end
end
