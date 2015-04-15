require_relative 'base'
require_relative '../orb_archetyper/rules/naming_conventions/file_names'

class TemplateArchetyperMetadata < Template
  def template_file
    'jenkins_yml.erb'
  end

  def output_file
    'jenkins.yml'
  end

  def project_type
    template_data[:project_type]
  end
end
