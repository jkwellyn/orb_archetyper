require_relative 'template'

class TemplateDotRspec < Template
  def template_file
    'dot_rspec.erb'
  end

  def output_file
    '.rspec'
  end
end
