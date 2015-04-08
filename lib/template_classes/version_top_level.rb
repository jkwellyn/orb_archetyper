require_relative 'base'

class TemplateVersionTopLevel < Template
  def version
    '2.0.2'
  end

  def template_file
    'version.erb'
  end

  def output_file
    'version.rb'
  end

  def gemspec_require_path
    File.join('..', 'version')
  end
end
