# Because we are loading this file from inside a .gemspec we are forced to do some LOAD_PATH gymnastics.
# We can't load 3rd party code from the .gemspec as one might expect without doing something like this.
require 'rubygems/dependency_installer'

gem_spec = ['orb_build_lifecycle', '~> 2.2']
build_lifecycle_gem = Gem::Specification.find_all_by_name(*gem_spec).first
build_lifecycle_gem = Gem::DependencyInstaller.new.install(*gem_spec).first unless build_lifecycle_gem
build_lifecycle_gem.add_self_to_load_path

require 'orb_build_lifecycle/utils/version_utils'

module OrbArchetyper
  VERSION = OrbBuildLifeCycle::Utils.rubygem_version
  ORB_ARCHETYPER = '1.0.1'
end
