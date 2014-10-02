# -*- encoding: utf-8 -*-
require File.expand_path('../lib/orb_archetyper/version', __FILE__)

Gem::Specification.new do |spec|
  spec.name          = 'orb_archetyper'
  spec.version       =  OrbArchetyper::VERSION
  spec.summary       = 'Orb archetyper: Project cookie cutter.'
  spec.description   = 'Generate template AQA projects: command line applications, core, test and utility projects.'
  spec.homepage      = 'https://github.va.opower.it/auto/orb_archetyper'
  spec.requirements << 'Ruby, v1.9.3.'

  spec.authors = ['Automation Services']
  spec.email = ['automation.services@opower.com']

  spec.required_ruby_version = '>= 1.9.3'
  spec.license       = 'MIT'

  # file attributes
  spec.files         = `git ls-files`.split($OUTPUT_RECORD_SEPARATOR)
  spec.executables   = spec.files.grep(/^bin\//) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(/^(test|spec|features)\//)
  spec.require_paths = ['lib']

  # Dev Dependencies
  spec.add_development_dependency('rake', '~> 10.1')
  spec.add_development_dependency('annotation_manager', '~> 1.0')
  spec.add_development_dependency('yard', '~> 0.8')
  spec.add_development_dependency('redcarpet', '~> 2.3')
  spec.add_development_dependency('rubocop', '~> 0.24')
  spec.add_development_dependency('simplecov', '~> 0.7')
  # This is necessary for the build script. We are locking to 0.1.2 because this gem has incorrect tags
  # that cause confusion with more permissive version specifications.
  spec.add_development_dependency('opower-deployment', '0.1.2')
  spec.add_development_dependency('test_support', '~> 1.0')

  # Runtime dependencies
  spec.add_dependency('orb_logger', '~> 1.0')
  spec.add_runtime_dependency('ansi', '~> 1.4')
  spec.add_runtime_dependency('git', '~> 1.2')
  spec.add_runtime_dependency('activesupport')
  spec.add_runtime_dependency('github_project', '~> 1.0')

  spec.post_install_message = 'Welcome to the oRb.'
end
