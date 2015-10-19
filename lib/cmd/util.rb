require 'semver'

class OrbCLI < Thor
  desc 'fork REPO', 'Fork a github repo. Repo name should include organization prefix, e.g. opower/myproject'
  def fork(repo)
    ForkGenerator.generate(repo)
  end

  desc 'version', 'Display version information'
  def version
    semver_dir = File.join(File.dirname(__FILE__), '..', '..')
    version_tag = SemVer.find(semver_dir)
    puts "orb_archetyper #{version_tag}"
  end
  map %w(-v --version) => :version
end
