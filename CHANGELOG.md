### [2.2.0] - 2015-17-07
- Updated gem templates to use orb_build_lifecycle 2.1 and new build script. 

### [2.1.3] - 2015-07-04
- Updated orb_github_project dependency

### [2.1.2] - 2015-06-15
- Updated orb_build_lifecycle dependency (runtime type and version bump)

### [2.1.1] - 2015-05-19
- Fix `orb -v` bug
- Fix version bug in generated projects

### 2.1.0
- Generate a usable out of the box config.yml for test projects
- Switch from ci_metadata.json to .jenkins.yml
- Rename view to view_name in jenkins_params
- Better use of username in templates

### 2.0.3
Fixed .ruby-version template - comments aren't supported

### 2.0.2
- Add semver support for generated projects

### 2.0.1
- No CHANGELOG generated for test projects

### 2.0.0
- Cleaned up CLI
- Added thor based support for cli projects
- Dropped support for meta projects
- Refactored/renamed template and project classes

### 1.3.0
- Switched from OptionParser to Thor

### 1.2.5
- Use attr_accessors instead of instance variables
- Style fixes (including comments)
- Add temp/ to .gitignore templates
- Updated file permissions (chmod 664) on README.md, Rakefile, Gemfile, gemspec

### 1.2.4
- Add project domain to the README.md

### 1.2.3
- Remove "v" prefix from CHANGELOG.md versions

### 1.2
- Test projects have execution configurations

### 1.1
- New bertha_test project type

### 0.0.5
- Add CHANGELOG.md template

### 0.0.4
- Use Yard instead of Rdoc
- Remove metrics:* tasks and metrics_fu gem from dependencies
- Fix spacing in generated README.md
- New meta project type
- Git workflow options -f and -u when generating projects
- Removed exclude and include (-e and -i) options when generating projects
- Added logging through orb_logger gem
- Moved test rake tasks into test_support gem
- Fixed all rubocop violations that were being generated; upgraded rubocop to 0.24.0
- Added rubocop to build script to be executed every time

### 0.0.3
- Added annotation_manager
- Build script renamed to build.sh; clean up of scripts using opower-deployment for ruby version
- Test files renamed from _test.rb to _spec.rb
- Test project type generates .rvmrc file
- Added CHANGELOG.md file

### 0.0.2
- Clean up of rake spec tasks
- New templating/project structure

### 0.0.1
- Initial orb_archetyper
