require_relative 'template'

class TemplateSpecTest < Template

  def template_file
    'spec_test.erb'
  end

  def output_file
    File.join("#{@project_name}_test.rb")
  end

  def output_directory
    File.join("#{super}/spec/unit")
  end

  def require_spec_helper
    '../spec_helper'
  end
end