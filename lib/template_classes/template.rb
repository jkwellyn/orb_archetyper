require 'erb'
require 'active_support/inflector'
require_relative '../orb-archetyper/rules/naming_conventions/file_names'

class Template
  include OrbArchetyper::Rules::NamingConventions::FileNames
  attr_reader :module_name
  attr_reader :project_name
  attr_accessor :template_data
  TEMPLATE_LOCATION = File.join(File.dirname(__FILE__), '..', 'templates')

  def initialize(project_name, module_name, template_data = {})
    @project_name = project_name
    @module_name = module_name
    @template_data = template_data
  end

  def render
    render_erb(self.template_file)
  end

  def partial(partial_file_name)
    render_erb(partial_file_name)
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

  def template_lookup(template_file)
    File.join(TEMPLATE_LOCATION, template_file)
  end

  def render_erb(file_path)
    ERB.new(File.read(template_lookup(file_path)), nil, '-').result(binding)
  end
end