require_relative 'base'
require_relative '../orb_archetyper/rules/naming_conventions/file_names'

class TemplateDotProjectYml < Template
  def template_file
    'dot_project_yml.erb'
  end

  def output_file
    '.project.yml'
  end

  def project_type
    template_data[:project_type]
  end
end
