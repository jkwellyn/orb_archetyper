#orb-archetyper - Project cookie cutter

Command line application to generate an auto-wired project type for AQA. 

Supported project types include:

1. Command line applications
2. Test Project (aka test launcher)
3. Utility Project (e.g. a client for a service)
4. Core project (e.g. SQL or Rest Connection manager) 

Projects are created with a predefined structure and are autowired with a set configuration.
This includes:

1. Rspec
 + Configured to only accept: the new expect syntax
 + RSpec test implementation for unit and acceptance tests
 + Rendered results reporting for - html/xml/console (jenkins and local)
2. Logging - console and logfile
3. Unit test coverage (simplecov)
4. Documentation (rdoc)
5. Static analysis (rubocop)
6. Metrics and stats (metric_fu)
7. Annotations - Rake notes (TODO, FIXME, OPTIMIZE) and orb-moon-raker
8. Rake tasks
9. Git project initialization
10. A jenkins build.sh script to simplify how jenkins executes/invokes commands

## Installation
 	
`$ gem install orb-archetyper`

## Usage

###Help

`$ orb-archetyper --help`
`$ orb-archetyper -h`

Show all subproject types:
`$ orb-archetyper -e`

### Create a new project
Where "my_project "is the name of your project.

`$ orb-archetyper -t cli -p my_project -x coverage -i spec,spec_help -x logs -g`

Note: Include, exclude is comma separated and contains no white space.
-g does a git init for ya.

###Output

Based on the following command, where project name = "command-line":
`$ orb-archetyper -t cli -p command-line -x coverage -i licence`


    Included licence into cli archetype.
    Excluded coverage from cli archetype.
    created `command-line`
    created `command-line`/logs
    created `command-line`/rdoc
    created `command-line`/resources
    created `command-line`/bin
    created `command-line`/bin/`command-line`
    created `command-line`/.gitignore
    created `command-line`/Gemfile
    created `command-line`/`command-line`.gemspec
    created `command-line`/lib
    created `command-line`/lib/`command-line`.rb
    created `command-line`/LICENCE
    created `command-line`/Rakefile
    created `command-line`/README.md
    created `command-line`/test
    created `command-line`/test/`command-line_test`.rb
    created `command-line`/lib/`command-line`
    created `command-line`/lib/`command-line`/version.rb
  

#### 1. Command Line Applications
A standardized CLI project.

#### 2. Test
An RSPEC test project that can be configured to be executed against a number of deployment tiers.

#### 3. Utility
A client interface to provide a reusable access point to a component/service/application under test.

#### 4. Core 
A core project that is used to facilitate automated testing common to all AQA. 

## Contributing

1. Fork it ( https://github.va.opower.it/auto/orb-archetyper )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
