class OrbCLI < Thor
  desc 'fork REPO', 'Fork a github repo. Repo name should include organization prefix, e.g. opower/myproject'
  def fork(repo)
    ForkGenerator.new.generate(repo)
  end

  desc 'version', 'Display version information'
  def version
    puts "orb-archetyper version #{OrbArchetyper::VERSION}"
  end
  map %w(-v --version) => :version
end
