# Orb Archetyper - Project cookie cutter

Command line application to generate a given project type for QA.

## Supported project types

orb_archetyper generates two general types of projects - test projects and gem projects.

### Rspec Test Projects (aka test launcher) generated with `-t test` or `-t bertha_test`
Description: Tests that can be configured to be executed against a number of deployment tiers. A `bertha_test` project is a more specialized `test` project that includes configuration files specifically to test Bertha jobs

Key Differences from Gem projects:
 - Test projects should include a Gemfile.lock (and lack a .gemspec as they are not gems) as test projects are essentially applications that can be run across multiple machines, and the precision enforced by bundler is extremely desirable to ensure consistent, reliable execution.
 - Test execution can get complex as the project may house various sets of tests that need to be run against different tiers, configurations (clients), and/or at different intervals (smoke vs regression). As a result, there will usually NOT be a 1-to-1 project to Jenkins job ratio for test projects.
 - The [test_support gem](https://github.va.opower.it/auto/test_support) supplies various tasks common to testing, e.g. [spec:from_config](https://github.va.opower.it/auto/test_support#rake-from-config) specifically addresses the previous bulletpoint.

### Gem Projects generated with `-t core` or `-t cli`
Description: Reusable libraries packaged as gems. These facilitate automated tasks common to all QA. Some examples of gem projects: Rest_Connection Manager, bertha-scheduler, any Archmage service client. A `cli` project is a more specialized `core` project that includes pre-wired Thor CLI files to help you write a CLI for your gem.

Key Differences from Test projects:
 - Gems should include a .gemspec to build the gem. They should not include a Gemfile.lock to allow projects across the widest possible range of dependencies to use it.
 - Test execution is fairly straightforward. Run all unit/e2e tests, build, install, deploy. As a result, there will usually be a 1-to-1 project to master Jenkins job ratio for gem projects.
 - The [build_lifecycle gem](https://github.va.opower.it/auto/build_lifecycle) supplies various tasks common to gems.

Projects are created with a predefined structure and are autowired with a set configuration.

This includes:

1. Rspec
    - Common Rspec configuration .rspec file generated
    - Configured to only accept the new expect syntax
    - RSpec test implementation for unit and acceptance tests
    - Rendered results reporting for - html/xml/console (jenkins and local)
2. Logging - console and logfile
3. Unit test coverage via simplecov
4. Documentation via yard
5. Style check via rubocop
6. Annotations - annotation_manager built on top of rake-notes (TODO, FIXME, OPTIMIZE)
7. Changelog - document changes between versions
8. Git project initialization
9. A build.sh script to simplify how Jenkins executes/invokes commands. This script can (and should) be used locally to double check your changes before pushing a PR.

## Usage

### Installation

    $ gem install orb_archetyper

### Help

    $ bin/orb help

### Create a new project

For the purposes of this README, we will be creating a CLI project (`-t cli`), but check the usage for the various other project types you can create.

##### A new CLI project that pushes to your Github automatically (assuming proper setup)

    $ bin/orb -t cli -p <project>

##### A new CLI project immediately pushed to an upstream Github organization (assuming proper credentials) and your fork

    $ bin/orb -t cli -p <project> -o <organization>

##### A new CLI project without creating a git repo for the project

    $ bin/orb -t cli -p <project> --no-github

### Fork an existing project from a given organization

You must specify the upstream organization and the project name separated by `/`

    $ bin/orb fork auto/orb_archetyper

### Running the New Project

Shows all the available rake tasks:

    $ bundle exec rake -T

Tasks to run tests:

    $ rake spec:e2e         # Run RSpec code examples
    $ rake spec:full        # Run all tests
    $ rake spec:Unit        # Run RSpec code examples

### Versioning

In the past, versions were stored as a Ruby String in version.rb. Now, we use the .semver file to store the versions.
The .semver file should not be edited by hand, but manipulated programmatically via the
[semver2 gem](https://rubygems.org/gems/semver2). After `bundle install` you will have an executable called `semver`
on your path. Run `bundle exec semver help` for details.

### Github Access

In order for the Github interactions to work, please do the following:

1. Go to `https://github.va.opower.it/settings/applications`
2. Create a new token
3. Add the following to your .bashrc: `export GITHUB_ACCESS_TOKEN=<token>`
4. `. ~/.bashrc`

## CI Integration

QA Jenkins Master - [http://qa-jenkins-master-1002.va.opower.it:8080/](http://qa-jenkins-master-1002.va.opower.it:8080/)

Jobs for the master branch and for any PRs will automatically get created if:

- the project has a build.sh at the top level of your project (this is automatically generated for you)
- the fork the PR is coming from is named the same as the main project

AND your project is either:

- in the auto Github organization OR
- listed on the `AUTO_PROJECT_WHITE_LIST` [whitelist of the job cutter](https://github.va.opower.it/auto/jenkins-seed/blob/master/src/main/groovy/opower/xweb/jenkins/jobs/JobWhiteLists.groovy)

You can specify the view that your job will appear under in the `ci_metadata.json` file using the `jenkins_view` key. If no value is set for `jenkins_view` or no `ci_metadata.json` file is found, the job will appear on the "No Assigned View" views.

Again, if your test project has various different run configurations, see [test_support#rake-from-config](https://github.va.opower.it/auto/test_support#rake-from-config) for how to set up the configuration to create your jobs.

## Contributing

#### Contacts
- Automation Services (automation.services@opower.com)
- John Crimmins (john.crimmins@opower.com)
- Crystal Hsiung (crystal@opower.com)

#### Process
1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
