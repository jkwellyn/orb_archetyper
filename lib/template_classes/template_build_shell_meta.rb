require_relative 'template'

class TemplateBuildShellMeta < Template
  def output_file
    'build.sh'
  end

  def template_file
    'build_sh_meta.erb'
  end

  def gemspec_name
    "#{project_name}.gemspec"
  end

  def post_install_actions(file_path)
    File.chmod(0755, file_path)
  end
end
