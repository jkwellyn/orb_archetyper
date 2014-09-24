# -*- encoding: utf-8 -*-
require File.expand_path('../lib/orb_archetyper/version', __FILE__)

Gem::Specification.new do |spec|
  spec.name          = 'orb_archetyper'
  spec.version       =  OrbArchetyper::VERSION
  spec.summary       = 'Orb archetyper: Project cookie cutter.'
  spec.description   = 'Generate template AQA projects: command line applications, core, test and utility projects.'
  spec.homepage      = 'https://github.va.opower.it/auto/orb_archetyper'
  spec.requirements << 'Ruby, v1.9.3.'

  spec.authors       = ['euan.davidson']
  spec.email         = ['euan.davidson@opower.com']

  spec.required_ruby_version = '>= 1.9.3'
  spec.license       = 'MIT'

  # file attributes
  spec.files         = `git ls-files`.split($OUTPUT_RECORD_SEPARATOR)
  spec.executables   = spec.files.grep(/^bin\//) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(/^(test|spec|features)\//)
  spec.require_paths = ['lib']

  # Dev Dependencies
  spec.add_development_dependency('rake', '10.1.1')
  spec.add_development_dependency('annotation_manager', '0.0.2')
  spec.add_development_dependency('yard', '~> 0.8.7')
  spec.add_development_dependency('redcarpet', '~> 2.3.0')
  spec.add_development_dependency('rspec', '2.14.1')
  spec.add_development_dependency('rspec-extra-formatters', '0.4')
  spec.add_development_dependency('rubocop', '0.24.0')
  spec.add_development_dependency('simplecov', '0.7.1')
  spec.add_development_dependency('fuubar', '1.3.2')
  spec.add_development_dependency('opower-deployment')
  spec.add_development_dependency('test_support', '0.0.3')

  # Runtime dependencies
  spec.add_dependency('orb_logger', '0.0.1')
  spec.add_runtime_dependency('ansi', '1.4.3')
  spec.add_runtime_dependency('git', '1.2.6')
  spec.add_runtime_dependency('activesupport')
  spec.add_runtime_dependency('github_project', '0.0.2')

  spec.post_install_message = 'Welcome to the oRb.'
end
