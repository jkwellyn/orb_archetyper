# -*- encoding: utf-8 -*-
require File.expand_path('../lib/orb-archetyper/version', __FILE__)

Gem::Specification.new do |spec|
 spec.name          = "orb-archetyper"
 spec.version       =  OrbArchetyper::VERSION
 spec.summary       = "Orb archetyper: Project cookie cutter."
 spec.description   = "Generate template AQA projects: command line applications, core, test and utility projects."
 spec.homepage      = "https://github.va.opower.it/euan-davidson/orb-archetyper"
 spec.requirements << 'Ruby, v1.9.3.'

 spec.authors       = ["euan.davidson"]
 spec.email         = ["euan.davidson@opower.com"]

 spec.required_ruby_version = ">= 1.9.3"
 spec.license       = "MIT"

#file attributes
 spec.files         = `git ls-files`.split($\)
 spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
 spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
 spec.require_paths = ["lib"]

#Dev Dependencies
 spec.add_development_dependency('metric_fu', '>= 4.0')
 spec.add_development_dependency('rake', '10.1.1')
 spec.add_development_dependency('rake-notes', '0.2.0')
 spec.add_development_dependency('rdoc', '>= 4.0')#'> 2.4.2')
 spec.add_development_dependency('rspec', '2.14.1')
 spec.add_development_dependency('rspec-extra-formatters', '0.4')
 spec.add_development_dependency('rubocop', '0.16.0')
 spec.add_development_dependency('simplecov', '0.7.1')
 spec.add_development_dependency('ci_reporter')
 spec.add_development_dependency('fuubar', '1.3.2')
 spec.add_development_dependency('nyan-cat-formatter', '0.5.2')

#Runtime dependencies
 spec.add_runtime_dependency('ansi', '1.4.3')

 spec.post_install_message = "Welcome to the oRb."
end
