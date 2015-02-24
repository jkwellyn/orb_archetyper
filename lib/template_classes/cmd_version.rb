require_relative 'base'

class TemplateCommandVersion < Template
  def template_file
    'cmd_version.erb'
  end

  def output_directory
    File.join(project_name, 'lib', 'commands')
  end

  def output_file
    'version.rb'
  end
end
