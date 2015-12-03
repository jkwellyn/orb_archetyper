module OrbArchetyper
  require 'yaml'
  contents = File.read(File.join(File.dirname(__FILE__), '..', '..', '.semver'))
  parsed = YAML.parse(contents).to_ruby
  special = parsed[:special].empty? ? '' : ".#{parsed[:special]}"
  VERSION = "#{parsed[:major]}.#{parsed[:minor]}.#{parsed[:patch]}#{special}"
  ORB_ARCHETYPER = '1.0.1'
end
