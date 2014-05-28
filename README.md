#orb-archetyper - Project cookie cutter

Command line application to generate a given project type for QA.

Supported project types include:

1. Command line applications
2. A Rspec Test Project (aka test launcher) that can be configured to be executed against a number of deployment tiers.
3. Utility Project (e.g. a client for a service) to provide a reusable access point to a component/service/application under test.
4. Core project (e.g. SQL or Rest Connection manager) used to facilitate automated testing common to all QA.

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
7. Annotations - annotation_manager built on top of rake-notes (TODO, FIXME, OPTIMIZE)
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

Some like it plain:

`$ orb-archetyper -t cli -p my_project`

Want more bells and whistles?

-g does a git init for ya.

-i or -x includes/excludes files.
Note: Include, exclude is comma separated and contains no white space.
Use the name of the files found in lib/templates, dropping the .erb at the end

####Output

Based on the following command, where project name = "command-line", excluding a .metrics file and including a .rspec file:

`$ orb-archetyper -t cli -p command-line -x dot_metrics -i dot_rspec`

	created command-line/build.bash
	created command-line/.gitignore
	created command-line/Rakefile
	created command-line/README.md
	created command-line/.rspec
	created command-line/lib/command-line/version.rb
	created command-line/Gemfile
	created command-line/command-line.gemspec
	created command-line/spec/unit/command-line_test.rb
	created command-line/lib/command-line.rb
	created command-line/lib/tasks.rb
	created command-line/spec/spec_helper.rb
	created command-line/bin/command-line
	created command-line/spec/unit

### Running my project

`bundle exec rake -T`
Shows all the available rake tasks.  Some (but not nearly ALL; please explore!!) of particular interest include:

Tasks to run tests!
```
rake spec:e2e                                    # Run RSpec code examples
rake spec:full                                   # Run all tests
rake spec:unit                                   # Run RSpec code examples
```

## Contributing

1. Fork it ( https://github.va.opower.it/auto/orb-archetyper )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
