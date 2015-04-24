require_relative 'base'
require 'semver'

class TemplateVersionTopLevel < Template
  def version
    version = SemVer.find
    version.format '%M.%m.%p%s'
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
