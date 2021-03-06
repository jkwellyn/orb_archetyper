require_relative 'base'
require_relative '../orb_archetyper/rules/naming_conventions/file_names'

class TemplateDotJenkinsYml < Template
  def template_file
    'dot_jenkins_yml.erb'
  end

  def output_file
    '.jenkins.yml'
  end

  def project_type
    template_data[:project_type]
  end
end
