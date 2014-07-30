require_relative 'template'

class TemplateDotRubocopYml < Template
  def template_file
    'dot_rubocop_yml.erb'
  end

  def output_file
    '.rubocop.yml'
  end
end
