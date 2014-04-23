require 'erb'
require 'active_support/inflector'
require_relative '../orb-archetyper/rules/naming_conventions/file_names'

class Template
  include OrbArchetyper::Rules::NamingConventions::FileNames
  attr_reader :module_name
  attr_reader :project_name
  TEMPLATE_LOCATION = File.join(File.dirname(__FILE__), '..', 'templates')

  def initialize(project_name, module_name)
    @project_name = project_name
    @module_name = module_name
  end

  def render
    ERB.new(File.read(template_path), nil, '-').result(binding)
  end

  def output_directory
    @project_name
  end

  def post_install_actions(file_path)
    #Sublcasses should override if necessary.
  end

  def self.convert_to_templates_class(template_name)
    "template_#{template_name}".camelize.constantize
  end

  private

  def template_path
    File.join(TEMPLATE_LOCATION, self.template_file)
  end
end