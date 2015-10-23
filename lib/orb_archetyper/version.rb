module OrbArchetyper
  begin
    require 'semver'
    semver_dir = File.join(File.dirname(__FILE__), '..', '..')
    VERSION = SemVer.find(semver_dir).format('%M.%m.%p%s').gsub('-', '.')
  rescue LoadError
    # First time through when semver gem isn't installed yet.
    VERSION = '0.0.0'
  end
  ORB_ARCHETYPER = '1.0.1'
end
