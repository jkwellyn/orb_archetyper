#Orb Archetype Generator

  Command line application to generate an auto-wired project type. 
  Supported project types include:
  1. Command line interface (cli)
  2. Core Project
  3. Utility Project
  4. Test Project

  Projects come with predefined structure, dependency injection and default tasks added. 
  Logging, results reporting, coverage, documentation, static analysis...

  ## Installation

  Add this line to your application's Gemfile:

      gem 'orb-archetyper'

  And then execute:

      $ bundle orb-archetyper

  Or install it yourself as:

      $ gem install orb-archetyper

  ## Usage

  Just now run from /bin/orb-archetyper:

  i.e.
  $ 'ruby orb-archetyper.rb --type cli -p comand-line -x coverage -i licence'

  Usage: orb-archetyper COMMAND [OPTIONS]
  Specific options:
      -t, --type [TYPE]                Select project type (cli, core, utility, test).
      -p, --project [STRING]           Specify the project name.

  Optional options:
      -x, --exclude x,y,z              Explicitly state the files/folders you wish to EXCLUDE from the archetype.
      -i, --include x,y,z              Explicitly state the files/folders you wish to INCLUDE into the archetype.
      -d, --directoy [STRING]          Specify the target directoy, if not pwd.
      -g, --[no-]github                Create the git repo for the project,
                                       False if omitted, true if declared.

  Common options:
      -e, --expand                     Display file/folder choices.
      -v, --version                    Display version
      -h, --help                       Show help


  ###Output

  Based om the following command:
  'ruby orb-archetyper.rb --type cli -p comand-line -x coverage -i licence'

* Included licence into cli archetype.
* Excluded coverage from cli archetype.
* created 'comand-line'
* created 'comand-line'/logs
* created 'comand-line'/rdoc
* created 'comand-line'/resources
* created 'comand-line'/bin
* created 'comand-line'/bin/'comand-line'
* created 'comand-line'/.gitignore
* created 'comand-line'/Gemfile
* created 'comand-line'/'comand-line'.gemspec
* created 'comand-line'/lib
* created 'comand-line'/lib/'comand-line'.rb
* created 'comand-line'/LICENCE
* created 'comand-line'/Rakefile
* created 'comand-line'/README.md
* created 'comand-line'/test
* created 'comand-line'/test/'comand-line_test'.rb
* created 'comand-line'/lib/'comand-line'
* created 'comand-line'/lib/'comand-line'/version.rb
  
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
