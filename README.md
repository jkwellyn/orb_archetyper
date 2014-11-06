# orb_archetyper - Project cookie cutter

Command line application to generate a given project type for QA.

# Usage

## Installation

`$ gem install orb_archetyper`

##Help

`$ orb_archetyper -h`

## Create a new project

### A new CLI project not pushed to Github

`$ orb_archetyper -t cli -p <project>`

### A new CLI project immediately pushed to a new Github repo owned by you 

`$ orb_archetyper -t cli -p <project> -u`

### A new CLI project immediately pushed to an upstream Github organization (assuming proper credentials) and your fork

`$ orb_archetyper -t cli -p <project> -u <organization>`

### Fork an existing project from a given organization

You must specify the upstream organization and the project name separated by '/'

`$ orb_archetyper -f auto/orb_archetyper`

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

The orb_archetyper will generate an empty shell of a project when you generate with `-t meta`.  In order to hook in your sub-projects to the meta project:

1. Generate the appropriate project type (likely core or utility) WITHIN the meta project's folder.

2. Add your sub-project to the list of projects within the meta project's Rakefile.

## CI Integration

QA Jenkins Master - http://qa-jenkins-master-1002.va.opower.it:8080/

Jobs for the master branch and for any PRs will automatically get created if:
+ the project has a build.sh at the top level of your project (this is automatically generated for you)
+ the fork the PR is coming from is named the same as the main project 

AND your project is either:
+ in the auto Github organization OR
+ listed on the AUTO_PROJECT_WHITE_LIST whitelist of the job cutter, located here: https://github.va.opower.it/auto/jenkins-seed/blob/master/src/main/groovy/opower/xweb/jenkins/jobs/JobWhiteLists.groovy

You can specify the view that your job will appear under in the ci_metadata.json file using the `jenkins_view` key. If no value is set for `jenkins_view` or no ci_metadata.json file is found, the job will appear on the "No Assigned View" views.

## Contributing

#### Contacts
+ John Crimmins (john.crimmins@opower.com)
+ Crystal Hsiung (crystal@opower.com)

#### Process
1. Fork it ( https://github.va.opower.it/auto/orb_archetyper )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
