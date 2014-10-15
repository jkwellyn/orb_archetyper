require_relative 'template_rakefile'

class TemplateRakefileGem < TemplateRakefile
  def template_file
    'rakefile_gem.erb'
  end
end
