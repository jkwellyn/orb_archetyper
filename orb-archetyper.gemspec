# -*- encoding: utf-8 -*-
require File.expand_path('../lib/orb-archetyper/version', __FILE__)
  
  Gem::Specification.new do |spec|
    spec.name          = "orb-archetyper"
    spec.version       =  OrbArchetyper::VERSION
    spec.summary       = "Orb archetyper: Project cookie cutter."
    spec.description   = "Generate template AQA projects: command line applications, core, test and utility projects."
    spec.homepage      = "https://github.va.opower.it/euan-davidson/orb-archetyper"
    
    spec.authors       = ["euan.davidson"]
    spec.email         = ["euan.davidson@opower.com"]

    spec.license       = "MIT"
    
    #file attributes...
    spec.files         = `git ls-files`.split($\)
    spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
    spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
    spec.require_paths = ["lib"]

    #Dependencies...
    spec.add_development_dependency 'rake'
    spec.add_development_dependency 'rspec'
    spec.add_development_dependency' rspec-extra-formatters' 
    spec.add_development_dependency 'rdoc'
    spec.add_development_dependency 'ansi'
  end
