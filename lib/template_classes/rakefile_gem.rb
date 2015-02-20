require_relative 'rakefile'

class TemplateRakefileGem < TemplateRakefile
  def template_file
    'rakefile_gem.erb'
  end
end
