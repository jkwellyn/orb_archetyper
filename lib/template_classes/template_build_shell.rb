require_relative 'template'

class TemplateBuildShell < Template

  def output_file
    'build.sh'
  end

  def template_file
    'build_sh.erb'
  end

end