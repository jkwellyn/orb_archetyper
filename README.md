#Orb Archetype Generator

Command line application to generate an auto-wired project type. 
Supported project types include:
1. Command line application
2. Orb Core Project
3. Utility Project 
4. Test Project

  Generated projects are created with a predefined structure, dependency injection and default rake tasks added. 
  Including
  1. Rendered results reporting for rspec - html/xml
  2. Unit test coverage (simplecov)
  3. Documentation (rdoc)
  4. static analysis (rubocop and reek)
  5. Annotations - Rake notes (TODO, FIXME, OPTIMIZE)

  ## Installation

  Build the gem locally

  `$ gem build orb-archetyper.gemspec `

  Install it yourself as:

      `$ gem install orb-archetyper-0.0.1.gem`

  ## Usage

  Help

  `$ orb-archetyper --help`

  ### Create a new project

  `$ orb-archetyper - cli -p comand-line -x coverage -i licence`


  ###Output

  Based om the following command, where project name = "command-line":
  `$ orb-archetyper -t cli -p comand-line -x coverage -i licence`

* Included licence into cli archetype.
* Excluded coverage from cli archetype.
* created `comand-line`
* created `comand-line`/logs
* created `comand-line`/rdoc
* created `comand-line`/resources
* created `comand-line`/bin
* created `comand-line`/bin/`comand-line`
* created `comand-line`/.gitignore
* created `comand-line`/Gemfile
* created `comand-line`/`comand-line`.gemspec
* created `comand-line`/lib
* created `comand-line`/lib/`comand-line`.rb
* created `comand-line`/LICENCE
* created `comand-line`/Rakefile
* created `comand-line`/README.md
* created `comand-line`/test
* created `comand-line`/test/`comand-line_test`.rb
* created `comand-line`/lib/`comand-line`
* created `comand-line`/lib/`comand-line`/version.rb
  
### Archetype Structure

#### 1. Command Line Application

* binf
* gemfile
* gemspec
* gitignore 
* libf 
* logs
* rake 
* readme
* resources
* rdoc
* test
* coverage
* version

#### 2. Core 
A core Orb project that is used to facilitate automated testing. 

* coverage
* gemfile
* gemspec
* gitignore
* libf
* rake
* rdoc
* readme
* test
* version

#### 3. Utility
A client interface to provide a reusable access point to a component/service/application under test.

 * config
 * coverage
 * gemfile 
 * gemspec 
 * gitignore
 * libf 
 * rake
 * rdoc
 * readme
 * test
 * version  

#### 4. Test
An RSPEC test project that can be executed against a number of deployment tiers.

* config - environment configuration 
* coverage
* gemfile
* gemlock
* gitignore
* libf
* logs
* rake
* readme
* resources
* results - used by jenkins
* rvmrc
* test - unit tests on test projects
* spec - functional automated tests

  ## Contributing

  1. Fork it ( https://github.va.opower.it/euan-davidson/orb-archetyper )
  2. Create your feature branch (`git checkout -b my-new-feature`)
  3. Commit your changes (`git commit -am 'Add some feature'`)
  4. Push to the branch (`git push origin my-new-feature`)
  5. Create new Pull Request
