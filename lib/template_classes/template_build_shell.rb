require_relative 'template'

class TemplateBuildShell < Template
  def output_file
    'build.sh'
  end

  def template_file
    'build_sh.erb'
  end

  def post_install_actions(file_path)
    File.chmod(0755, file_path)
  end
end
