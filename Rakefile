#!/usr/bin/env rake
require 'rspec/core/rake_task'
require 'rspec-extra-formatters'
require 'rspec/core'
require 'rubocop/rake_task'
require 'rdoc/task'
require 'reek/rake/task'
require 'rake/notes/rake_task'

def timestamp
	Time.now.strftime("%Y%m%d_%H%M%S")
end

RSpec::Core::RakeTask.new(:rspec_unit) do |t|
  t.rspec_opts = ['-c']
  t.rspec_opts << '--require' << 'rspec-extra-formatters'
  t.rspec_opts << '--format' << JUnitFormatter
  t.rspec_opts << '--out' << "results/unit/#{timestamp}_results.xml"
  t.rspec_opts << '--format' << 'html'
  t.rspec_opts << '--out' << "results/unit/#{timestamp}_results.html"
  t.pattern = 'test/**/*test.rb'
end

RDoc::Task.new(:rdoc) do |rdoc|
    rdoc.rdoc_dir = 'rdoc'
    rdoc.title = 'orb-archetyper'
    rdoc.main = 'README.md'
    rdoc.rdoc_files.include('README*', 'lib/**/*.rb')
end

Reek::Rake::Task.new do |t|
  t.fail_on_error = false
end

desc 'Run RuboCop on the lib directory'
Rubocop::RakeTask.new(:rubocop) do |task|
  task.patterns = ['lib/**/*.rb']
  # only show the files with failures
  #task.formatters = ['files', 'offences']
  # don't abort rake on failure
  task.fail_on_error = false
  #display cop names
  #task.options << '-D'
  task.options << '-o' << "coverage/rubocop_#{timestamp}.txt"
end

=begin
require 'rake/clean'
namespace :clobber do

	desc "Remove simplecov files"
	task :coverage do
		CLEAN = FileList['coverage/*']
		puts "Done."
	end

	desc "Remove Unit Results files"
	task :results do
		CLEAN = FileList['results/unit/*']
		puts "Done."
	end
end
=end