# Orb Archetyper - Project cookie cutter

Command line application to generate a given project type for QA.

## Supported project types

orb_archetyper generates two general types of projects - test projects and gem projects.

#### Rspec Test Projects (aka test launcher) generated with `-t test` or `-t bertha_test`

Description: Tests that can be configured to be executed against a number of deployment tiers.
A `bertha_test` project is a more specialized `test` project that includes configuration files specifically to test Bertha jobs.

Key Differences from Gem projects:
 - Test projects should include a Gemfile.lock (and lack a .gemspec as they are not gems) as test projects are essentially applications
 that can be run across multiple machines, and the precision enforced by bundler is extremely desirable to ensure consistent,
 reliable execution.
 - Test execution can get complex as the project may house various sets of tests that need to be run against different tiers,
 configurations (clients), and/or at different intervals (smoke vs regression). As a result, there will usually NOT be a 1-to-1 project
 to Jenkins job ratio for test projects.
 - The [orb_test_support gem](https://github.va.opower.it/auto/orb_test_support) supplies various tasks common to testing,
 e.g. [spec:from_config](https://github.va.opower.it/auto/orb_test_support#rake-from-config) specifically addresses the previous bulletpoint.

#### Gem Projects generated with `-t core` or `-t cli`

Description: Reusable libraries packaged as gems. These facilitate automated tasks common to all QA. Some examples of gem projects:
Rest_Connection Manager, bertha-scheduler, any Archmage service client.
A `cli` project is a more specialized `core` project that includes pre-wired Thor CLI files to help you write a CLI for your gem.

Key Differences from Test projects:
 - Gems should include a .gemspec to build the gem. They should not include a Gemfile.lock to allow projects across the widest
 possible range of dependencies to use it.
 - Test execution is fairly straightforward. Run all unit/e2e tests, build, install, deploy. As a result, there will usually be a
 1-to-1 project to master Jenkins job ratio for gem projects.
 - The [orb_build_lifecycle gem](https://github.va.opower.it/auto/orb_build_lifecycle) supplies various tasks common to gems.

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
6. Changelog - document changes between versions
7. Git project initialization
8. A build.sh script to simplify how Jenkins executes/invokes commands.
This script can (and should) be used locally to double check your changes before pushing a PR.
9. (gem projects only) A release.sh script to simplify how Jenkins releases the gem. 
## Usage

### Installation

    $ gem install orb_archetyper

### Help

    $ bin/orb help

### Create a new project

For the purposes of this README, we will be creating a CLI project (`-t cli`), but check the usage for the various other project
types you can create.

##### A new CLI project that pushes to your Github automatically (assuming proper setup)

    $ bin/orb -t cli -p <project>

##### A new CLI project immediately pushed to an upstream Github organization (assuming proper credentials) and your fork

    $ bin/orb -t cli -p <project> -o <organization>

##### A new CLI project immediately pushed to an upstream Github organization (assuming proper credentials) owned by given team

If you are not the owner of the provided organization but you are a member of a team which has permissions on the organization,
you can specify a 'team' option, and create the repo on behalf of that team.

    $ bin/orb -t cli -p <project> -o <organization> --team <team>

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
    $ rake spec:unit        # Run RSpec code examples

## CI Integration

QA Jenkins Master - [http://qa-jenkins-master-1002.va.opower.it:8080/](http://qa-jenkins-master-1002.va.opower.it:8080/)

Jobs for the master branch and for any PRs will automatically get created if:

- the project has a build.sh at the top level of your project (this is automatically generated for you)
- the fork the PR is coming from is named the same as the main project

AND your project is either:

- in the [auto](https://github.va.opower.it/auto) Github organization OR
- listed on the `AUTO_PROJECT_WHITE_LIST` [whitelist of the job cutter](https://github.va.opower.it/auto/jenkins-seed/blob/master/src/main/groovy/opower/xweb/jenkins/jobs/JobWhiteLists.groovy)

If you are not in the [auto](https://github.va.opower.it/auto) Github organization, please speak to someone in Automation Services about additional permissions (e.g. Jenkins user must be an owner in order to access webhooks).

You can specify a number of global project-wide parameters in the `.jenkins.yml` file, such as:

  `view_name`                       name of the jenkins view that your job will appear under.
                                    If no value is provided or no `.jenkins.yml` file is found, the job will appear under the `~ noView` view.
  `notification_email`              email address to send out notifications to when the jenkins job fails
  `cron_schedule`                   cron-based schedule for running the job. Default: 'H 3 * * *'
  `auto_create`                     if set to `false` no jenkins jobs will be created for the project. Default: true
  `auto_release`                    if set to `true`, a jenkins job will be created to release the project. Default: false
  `test_ruby_versions`              space delimited list of ruby versions to run tests against. Only for gem projects
  `release_ruby_version`            a single ruby version to perform the release of a gem in. Only for gem projects

If your test project has various different run configurations, see [orb_test_support#rake-from-config](https://github.va.opower.it/auto/orb_test_support#rake-from-config)
for how to set up the configuration to create your jobs. Run configuration parameters will override the correspoinding global
project-wide parameters.

For gems, the build status for your job has already been templatized to the top of your README.

### Github Access

In order for the Github interactions to work, please do the following:

1. Go to `https://github.va.opower.it/settings/applications`
2. Create a new token
3. Add the following to your .bashrc: `export GITHUB_ACCESS_TOKEN=<token>`
4. `. ~/.bashrc`

## Gem Testing, Versioning, and Releasing
orb_archetyper relies on the [`release` task](https://github.va.opower.it/auto/orb_build_lifecycle) of orb_build_lifecycle to release gems.

## Testing against Multiple Ruby Versions
If you wish to test your gem against multiple versions of Ruby, you can specify what version to use by setting the `test_ruby_versions` value in the `.jenkins.yml`. Currently, this list is a space delimited list of Ruby versions.

```yaml
# .jenkins.yml
---
project_type: core
view_name:    auto_core
test_ruby_versions: 1.9.3-p392 2.1.2 2.2.2
release_ruby_version: 1.9.3-p392
```

The jenkins-seed project will read this configuration and set up your test job to be a matrix configured project. There will be a separate sub-job for each ruby version you specify and you will be able to see the status of your gem's test run against the different listed Ruby versions.
![multi_ruby](https://github.va.opower.it/github-enterprise-assets/0000/0017/0000/2390/b0808860-6774-11e5-94e4-f2c70b4d4218.png)

## Versioning

In the past, versions were stored as a Ruby String in version.rb. Now, we use the `.semver` file to store the versions.
The `.semver` file should not be edited by hand, but manipulated programmatically via the
[semver2 gem](https://rubygems.org/gems/semver2). After `bundle install` you will have an executable called `semver`
on your path. Run `bundle exec semver help` for details.

## Automatic Gem Deployment Jenkins Job
In order to turn on automatic release, you must specify `auto_release` to `true` in your `.jenkins.yml`. You will also need to set `release_ruby_version` with the version of Ruby you want to release with.

Once this is turned on, you should see two Jenkins jobs get created - one to test your gem and one to release it.
![release_job](https://github.va.opower.it/github-enterprise-assets/0000/0017/0000/2389/f7c20614-6773-11e5-9282-d14f70aa11bf.png)

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
