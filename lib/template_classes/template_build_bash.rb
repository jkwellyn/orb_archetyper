require_relative 'template'

class TemplateBuildBash < Template

  def output_file
    'build.bash'
  end

  def template_file
    'build_bash.erb'
  end

end