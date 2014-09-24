require_relative 'template'
require_relative '../orb_archetyper/version'

class TemplateVersionTopLevel < Template
  def version
    OrbArchetyper::VERSION
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
