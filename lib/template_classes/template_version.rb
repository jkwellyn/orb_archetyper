require_relative 'template'
require_relative '../orb-archetyper/version'

class TemplateVersion < Template

  def version
    OrbArchetyper::VERSION
  end

  def template_file
    'version.erb'
  end

  def output_directory
    File.join(super, 'lib', super)
  end

  def output_file
    'version.rb'
  end

end