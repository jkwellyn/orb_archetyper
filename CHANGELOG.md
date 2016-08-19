### [2.13.1] - 2016-08-12
* Updated `tasks.rb` for `test` project types to require `spec_config` only once, after configuration is loaded

### [2.13.0] - 2016-03-29
* Switch projects from orb_configuration to clean_config

### [2.12.1] - 2016-03-25
* Update changelog template

### [2.12.0] - 2015-12-22
* Add metadata file .project.yml

### [2.11.1] - 2015-12-14
* AUTO-950 - Add docs and template change for results persistence

### [2.11.0] - 2015-12-02
* AUTO-971 - Remove reliance on semver gem for determining version.

### [2.10.0] - 2015-11-10
* AUTO-917 - Remove rvm/rbenv from build.sh and release.sh templates, AUTO-905 remove annotation_manager

### [2.9.0] - 2015-10-21
* Simplify gem versioning to not require orb_build_lifecycle at runtime

### [2.8.2] - 2015-10-19
* Reorganize files under lib

### [2.8.1] - 2015-10-15
* Fix .jenkins.yml test_ruby_versions format

### [2.8.0] - 2015-09-30
* Update bertha_test templates

### [2.7.0] - 2015-09-14
* release.sh for gem projects

### [2.6.0] - 2015-08-21
* Add `upload-team` option when uploading a new repo to GitHub

### [2.5.0] - 2015-08-13
* Build status link generated into README

### [2.4.0] - 2015-08-12
* Ruby version should be set external to the build script now
* Build script works with rbenv

### [2.3.0] - 2015-07-24
* Remove orb_annotation_manager from generated projects

### [2.2.1] - 2015-07-17
* Fix e2e tests so they won't release

### [2.2.0] - 2015-07-17
* Update gem templates to use orb_build_lifecycle 2.1 and new build script

### [2.1.3] - 2015-07-04
* Update orb_github_project dependency

### [2.1.2] - 2015-06-15
* Update orb_build_lifecycle dependency (runtime type and version bump)

### [2.1.1] - 2015-05-19
* Fix `orb -v` bug
* Fix version bug in generated projects

### 2.1.0
* Generate a usable out of the box config.yml for test projects
* Switch from ci_metadata.json to .jenkins.yml
* Rename view to view_name in jenkins_params
* Better use of username in templates

### 2.0.3
Fix .ruby-version template - comments aren't supported

### 2.0.2
* Add semver support for generated projects

### 2.0.1
* No CHANGELOG generated for test projects

### 2.0.0
* Clean up CLI
* Add thor based support for cli projects
* Drop support for meta projects
* Refactor/rename template and project classes

### 1.3.0
* Switch from OptionParser to Thor

### 1.2.5
* Use attr_accessors instead of instance variables
* Style fixes (including comments)
* Add temp/ to .gitignore templates
* Update file permissions (chmod 664) on README.md, Rakefile, Gemfile, gemspec

### 1.2.4
* Add project domain to the README.md

### 1.2.3
* Remove "v" prefix from CHANGELOG.md versions

### 1.2
* Test projects have execution configurations

### 1.1
* New bertha_test project type

### 0.0.5
* Add CHANGELOG.md template

### 0.0.4
* Use Yard instead of Rdoc
* Remove metrics:* tasks and metrics_fu gem from dependencies
* Fix spacing in generated README.md
* New meta project type
* Git workflow options -f and -u when generating projects
* Remove exclude and include (-e and -i) options when generating projects
* Add logging through orb_logger gem
* Move test rake tasks into test_support gem
* Fix all rubocop violations that were being generated; upgraded rubocop to 0.24.0
* Add rubocop to build script to be executed every time

### 0.0.3
* Add annotation_manager
* Build script renamed to build.sh; clean up of scripts using opower-deployment for ruby version
* Test files renamed from _test.rb to _spec.rb
* Test project type generates .rvmrc file
* Add CHANGELOG.md file

### 0.0.2
* Clean up of rake spec tasks
* New templating/project structure

### 0.0.1
* Initial orb_archetyper
