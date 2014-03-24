#orb-archetyper - Project cookie cutter

       .,,,.           ...           .,,,.
      ((o o))        (`@ @`)        ((6 6))
    ___\ - /___    ___\ o /___    ___\ v /___
   (&_   &   _&)  (&_   %   _&)  (&_   &   _&)
      |  %  |        |  &  |        |  %  |
      |  &  |        |  %  |        |  &  |
      /  %  \        /  &  \        /  %  \
    _/  / \  \_    _/  / \  \_    _/  / \  \_
   (&__/   \__&)  (&__/   \__&)  (&__/   \__&)


Command line application to generate an auto-wired project type for AQA. 

Supported project types include:
1. Command line application
2. Test Project (aka test launcher) 
3. Utility Project (e.g. a client for a service)
4. Core project

Projects are created with a predefined structure and are autorired with a set configuration. 
This inlcudes:

Rspec 
--configured for accepting only except the new expect syntax 
RSpec test implementation for unit and acceptance tests
Rendered results reporting for rspec - html/xml/console
Logging - console and logfile
Unit test coverage (simplecov)
Documentation (rdoc)
Static analysis (rubocop)
Metrics and stats (metric_fu)
Annotations - Rake notes (TODO, FIXME, OPTIMIZE)
Predefined rake tasks
Git initialization
A build.bash script to simplify how jenkins executes/invokes tests

## Installation
 

`$ gem install orb-archetyper`

## Usage

###Help

`$ orb-archetyper --help`
`$ orb-archetyper -h`
`$ orb-archetyper -h`

Show all subproject types:
`$ orb-archetyper -e`
  

### Create a new project
Where "project-a "is the name of your project.

`$ orb-archetyper -t cli -p my_project -x coverage -i spec,spec_help -x logs -g`

Note: Inlcude, exlcude is comma separated and comtains no white spaces.
-g does a git init for ya.

`$ orb-archetyper -t cli -p my_project -x coverage -i spec,spec_help -x logs -g`

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
  

#### 1. Command Line Applications

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
