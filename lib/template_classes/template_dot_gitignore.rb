require_relative 'template'

class TemplateDotGitignore < Template
  def template_file
    'dot_gitignore.erb'
  end

  def output_file
    '.gitignore'
  end
end