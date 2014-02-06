 # coding: utf-8
  lib = File.expand_path('../lib', __FILE__)
  $LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
  require_relative 'lib/orb-archetyper/version'

  Gem::Specification.new do |spec|
    spec.name          = "orb-archetyper"
    spec.version       = "OrbArchetyper::VERSION"
    spec.authors       = ["euan.davidson"]
    spec.email         = "euan.davidson@opower.com"
    spec.summary       = "Generate template projects: command line applications, core, test and utility projects."
    spec.description   = ""
    spec.homepage      = "https://github.va.opower.it/"
    spec.license       = 
    
    spec.files         = `git ls-files -z`.split("\x0")
    spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
    spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
    spec.require_paths = "lib"

    #Dependencies
    spec.add_development_dependency "rdoc"
    spec.add_development_dependency "rake"
  end
