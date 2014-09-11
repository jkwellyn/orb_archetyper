require_relative 'template'

class TemplateConfigYmlTest < Template
  def output_file
    'config.yml'
  end

  def output_directory
    File.join(@project_name, 'config')
  end

  def template_file
    'config_yml.erb'
  end

  def test_project?
    true
  end
end
