require_relative 'template'
require_relative '../orb_archetyper/rules/naming_conventions/file_names'

class TemplateBinCli < Template
  alias_method :output_file, :project_name

  def template_file
    'bin_cli.erb'
  end

  def output_directory
    File.join(project_name, 'bin')
  end

  def required_file
    "#{project_name}.rb"
  end

  def post_install_actions(file_path)
    File.chmod(0755, file_path)
  end
end
