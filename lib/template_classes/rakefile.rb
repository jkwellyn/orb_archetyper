require_relative 'base'

class TemplateRakefile < Template
  def template_file
    'rakefile.erb'
  end

  def output_file
    'Rakefile'
  end
end
