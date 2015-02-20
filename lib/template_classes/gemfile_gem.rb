require_relative 'base'

class TemplateGemfileGem < Template
  def template_file
    'gemfile_gem.erb'
  end

  def output_file
    'Gemfile'
  end
end
