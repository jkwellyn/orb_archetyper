require_relative 'base'

class TemplateBerthaJobConfigYml < Template
  def output_file
    'job_name.yml'
  end

  def output_directory
    File.join(project_name, 'config', 'job_configurations')
  end

  def template_file
    'bertha_job_config_yml.erb'
  end
end
