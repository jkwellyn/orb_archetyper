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
    render_erb(template_file)
  end

  def partial(partial_file_name)
    render_erb(partial_file_name)
  end

  def output_directory
    @project_name
  end

  def create
    output_dir = File.join(FileUtils.mkdir_p(output_directory))
    full_path = File.join(output_dir, output_file)
    File.write(full_path, render)
    post_install_actions(full_path)
    full_path
  end

  def post_install_actions(_args)
    # Subclasses should override if necessary
  end

  def self.convert_to_templates_class(template_name)
    "template_#{template_name}".camelize.constantize
  end

  # override == because include uses this
  def ==(other)
    other.class == self.class && @project_name == other.project_name && @module_name == other.send(:module_name) &&
        @template_data == other.template_data
  end

  # override eql? and hash in order to do set math in project.rb's make_template_set because hashing uses those 2
  def eql?(template2)
    self == template2
  end

  def hash
    @project_name.hash ^ @module_name.hash ^ self.class.hash
  end

  private

  def template_lookup(template_file)
    File.join(TEMPLATE_LOCATION, template_file)
  end

  def render_erb(file_path)
    ERB.new(File.read(template_lookup(file_path)), nil, '-').result(binding)
  end
end
