require_relative 'base'

class TemplateReleaseShell < Template
  def output_file
    'release.sh'
  end

  def template_file
    'release_sh.erb'
  end

  def post_install_actions(file_path)
    File.chmod(0755, file_path)
  end
end
