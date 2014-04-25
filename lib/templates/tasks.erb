#!/usr/bin/env rake
require 'rspec/core/rake_task'
require 'rspec-extra-formatters'
require 'rspec/core'
require 'rubocop/rake_task'
require 'rdoc/task'
require 'rake/notes/rake_task'
require 'metric_fu'
require 'fuubar'
require 'logger'

SANDBOX = File.join('spec', 'sandbox')
LOG = Logger.new(STDOUT)

def timestamp
  Time.now.strftime("%Y%m%d_%H%M%S")
end

def build_rspec_opts(test_type, task)
  task.rspec_opts = ['-c']
  task.rspec_opts << '--require' << 'fuubar'
  task.rspec_opts << '--format' << Fuubar
  task.rspec_opts << '--require' << 'rspec-extra-formatters'
  task.rspec_opts << '--format' << JUnitFormatter
  task.rspec_opts << '--out' << "tmp/results/#{test_type}/#{timestamp}_results.xml"
  task.rspec_opts << '--format' << 'html'
  task.rspec_opts << '--out' << "tmp/results/#{test_type}/#{timestamp}_results.html"
  task.pattern = "spec/#{test_type}/**/*_test.rb"
end

namespace :clobber do

  desc "Removing #{SANDBOX}"
  task :e2e do
    if Dir.exist?(SANDBOX)
      LOG.info("Deleting old #{SANDBOX}")
      FileUtils.rm_rf(SANDBOX)
    end
  end

  desc "Remove Simplecov files"
  task :coverage do
    puts "Clearing the coverage directory..."
    `rm -rf tmp/coverage/*`
    puts "Done."
  end

  desc "Remove ALL Tmp files"
  task :tmp do
    puts "Clearing the root tmp directory..."
    `rm -rf tmp/*`
    puts "Done."
  end

  desc "Remove Unit Test Results files"
  task :unit do
    puts "Clearing the unit test directory..."
    `rm -rf tmp/results/unit/*`
    puts "Done."
  end

  desc "Remove metrics results files"
  task :metrics do
    puts "Clearing the metrics directory..."
    `rm -rf tmp/metric_fu/*`
    puts "Done."
  end

end

namespace :spec do
  RSpec::Core::RakeTask.new(:unit => %w{clobber:tmp}) do |task|
    build_rspec_opts('unit', task)
  end

  RSpec::Core::RakeTask.new(:e2e => %w{clobber:tmp clobber:e2e}) do |task|
    LOG.info("Creating new #{SANDBOX}")
    Dir.mkdir(SANDBOX)
    build_rspec_opts('e2e', task)
  end

  RSpec::Core::RakeTask.new(:full => %w{spec:unit spec:e2e})
end

RDoc::Task.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'tmp/rdoc'
  rdoc.title = 'orb-archetyper'
  rdoc.main = 'README.md'
  rdoc.rdoc_files.include('README*', 'lib/**/*.rb')
end

desc 'Run RuboCop on the lib directory'
Rubocop::RakeTask.new(:rubocop) do |task|
  task.patterns = ['lib/**/*.rb']
  # only show the files with failures
  #task.formatters = ['files', 'offences']
  # don't abort rake on failure
  task.fail_on_error = false
  #task.options << '-o' << "coverage/rubocop_#{timestamp}.txt"
end

desc "Open latest unit test results in your yer browser"
task :open_unit_results do
  file = `find tmp/results/unit/ -regex ".*\.\html" | tail -1`
  `open #{file}`
end