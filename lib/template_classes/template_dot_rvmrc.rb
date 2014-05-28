require_relative 'template'

class TemplateDotRvmrc < Template

  def template_file
    'dot_rvmrc.erb'
  end

  def output_file
    '.rvmrc'
  end

end