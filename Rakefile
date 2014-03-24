#!/usr/bin/env rake
require 'ci/reporter/rake/rspec'
require 'rspec/core/rake_task'
require 'rspec-extra-formatters'
require 'rspec/core'
require 'rubocop/rake_task'
require 'rdoc/task'
require 'rake/notes/rake_task'
require 'metric_fu'

def timestamp
	Time.now.strftime("%Y%m%d_%H%M%S")
end

RSpec::Core::RakeTask.new(:spec_unit_ci => ["ci:setup:rspec"]) do |t|
  spec_opts = "--format html --out tmp/results/unit/#{timestamp}_results.html"
  ENV["SPEC_OPTS"] = "#{ENV['SPEC_OPTS']} #{spec_opts}"
  t.pattern = 'spec/**/*test.rb'
end

RSpec::Core::RakeTask.new(:spec_unit) do |t|
  t.rspec_opts = ['-c']
  #If you dont like cats: change out the nyan-cat for fuubar for your console output format
  t.rspec_opts << '--format' << 'NyanCatFormatter'
  #t.rspec_opts << '--require' << fuubar
  #t.rspec_opts << '--format' << Fuubar
  t.rspec_opts << '--require' << 'rspec-extra-formatters'
  t.rspec_opts << '--format' << JUnitFormatter
  t.rspec_opts << '--out' << "tmp/results/unit/#{timestamp}_results.xml"
  t.rspec_opts << '--format' << 'html'
  t.rspec_opts << '--out' << "tmp/results/unit/#{timestamp}_results.html"
  t.pattern = 'spec/unit/*test.rb'
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

desc "Remove Simplecov files"
  task :clobber_coverage do
    puts "Clearing the coverage directory..."
    `rm -rf tmp/coverage/*`
    puts "Done."
end

desc "Remove ALL Tmp files"
  task :clobber_tmp do
    puts "Clearing the root tmp directory..."
    `rm -rf tmp/*`
    puts "Done."
end

desc "Remove Unit Test Results files"
  task :clobber_unit do
    puts "Clearing the unit test directory..."
    `rm -rf tmp/results/unit/*`
    puts "Done."
end

desc "Remove metrics results files"
  task :clobber_metrics do
    puts "Clearing the metrics directory..."
    `rm -rf tmp/metric_fu/*`
    puts "Done."
end

desc "Open latest unit test results in your yer browser"
 task :open_unit_results do
  file = `find tmp/results/unit/ -regex ".*\.\html" | tail -1`
  `open #{file}`
end