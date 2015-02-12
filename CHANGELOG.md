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
