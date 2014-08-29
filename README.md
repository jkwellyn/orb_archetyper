# orb-archetyper - Project cookie cutter

Command line application to generate a given project type for QA.

# Usage

## Installation

`$ gem install orb-archetyper`

##Help

`$ orb-archetyper -h`

## Create a new project

### A new CLI project not pushed to Github

`$ orb-archetyper -t cli -p <project>`

### A new CLI project immediately pushed to a new Github repo owned by you 

`$ orb-archetyper -t cli -p <project> -u`

### A new CLI project immediately pushed to an upstream Github organization (assuming proper credentials) and your fork

`$ orb-archetyper -t cli -p <project> -u <organization>`

### Fork an existing project from a given organization

You must specify the upstream organization and the project name separated by '/'

`$ orb-archetyper -f auto/orb-archetyper`

### Running the New Project

Shows all the available rake tasks:

`bundle exec rake -T`

Tasks to run tests:

```
rake spec:e2e                                    # Run RSpec code examples
rake spec:full                                   # Run all tests
rake spec:unit                                   # Run RSpec code examples
```

## Github Access
In order for the Github interactions to work, please do the following:

1. Go to https://github.va.opower.it/settings/applications
2. Create a new token
3. Add the following to your .bashrc: `export GITHUB_ACCESS_TOKEN=<token>`
4. `. ~/.bashrc`

### Supported project types

1. Command line applications
2. A Rspec Test Project (aka test launcher) that can be configured to be executed against a number of deployment tiers.
3. Utility Project (e.g. a client for a service) to provide a reusable access point to a component/service/application under test.
4. Core project (e.g. SQL or Rest Connection manager) used to facilitate automated testing common to all QA.
5. Meta project (e.g. rails) used to collect related gems into 1 meta gem 

Projects are created with a predefined structure and are autowired with a set configuration.
This includes:

1. Rspec
 + Configured to only accept: the new expect syntax
 + RSpec test implementation for unit and acceptance tests
 + Rendered results reporting for - html/xml/console (jenkins and local)
2. Logging - console and logfile
3. Unit test coverage (simplecov)
4. Documentation (rdoc)
5. Style check (rubocop)
6. Annotations - annotation_manager built on top of rake-notes (TODO, FIXME, OPTIMIZE)
7. Rake tasks
8. Git project initialization
9. A jenkins build.sh script to simplify how jenkins executes/invokes commands


### Meta projects

#### TODO this section may change as we make more modifications to the archetyper

The orb-archetyper will generate an empty shell of a project when you generate with `-t meta`.  In order to hook in your sub-projects to the meta project:

1. Generate the appropriate project type (likely core or utility) WITHIN the meta project's folder.

2. Add your sub-project to the list of projects within the meta project's Rakefile.

## Contributing

#### Contacts
+ John Crimmins (john.crimmins@opower.com)
+ Crystal Hsiung (crystal@opower.com)

#### Process
1. Fork it ( https://github.va.opower.it/auto/orb-archetyper )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
