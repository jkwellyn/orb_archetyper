require_relative 'version_top_level'

class TemplateVersion < TemplateVersionTopLevel
  def output_directory
    File.join(super, 'lib', super)
  end

  def gemspec_require_path
    File.join('..', 'lib', project_name, 'version')
  end
end
