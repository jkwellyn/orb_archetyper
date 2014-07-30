require_relative 'template_build_shell'

class TemplateBuildShellApp < TemplateBuildShell
  def template_file
    'build_sh_app.erb'
  end
end
