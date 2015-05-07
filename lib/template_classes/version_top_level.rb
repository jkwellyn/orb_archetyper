require_relative 'base'
require 'semver'

class TemplateVersionTopLevel < Template
  def version
    semver_dir = File.join(File.dirname(__FILE__), '..', '..')
    version_tag = SemVer.find(semver_dir)
    version_tag.format '%M.%m.%p%s'
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
