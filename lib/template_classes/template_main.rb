require_relative 'template'

class TemplateMain < Template

  def template_file
    'main.erb'
  end

  def output_file
    "#@project_name.rb"
  end

  def output_directory
    File.join(super, 'lib')
  end

end