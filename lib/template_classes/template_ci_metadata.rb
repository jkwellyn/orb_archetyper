require_relative 'template'
require_relative '../orb_archetyper/rules/naming_conventions/file_names'

class TemplateArchetyperMetadata < Template
  def template_file
    'ci_metadata.json.erb'
  end

  def output_file
    'ci_metadata.json'
  end

  def project_type
    @template_data[:project_type]
  end
end
