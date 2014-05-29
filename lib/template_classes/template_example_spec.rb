require_relative 'template'

class TemplateExampleSpec < Template

  def template_file
    'example_spec.erb'
  end

  def output_file
    File.join("#{@project_name}_spec.rb")
  end

  def output_directory
    File.join("#{super}/spec/unit")
  end

  def require_spec_helper
    '../spec_helper'
  end
end