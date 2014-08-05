#!/usr/bin/env rake
require 'rspec/core/rake_task'
require 'rspec-extra-formatters'
require 'rspec/core'
require 'rubocop/rake_task'
require 'annotation_manager/rake_task'
require 'fuubar'
require 'yard'
require_relative 'orb-archetyper/constants'
require 'orb_logger'

TMP_DIR = 'tmp'
FileUtils.mkdir(TMP_DIR) unless File.exist?(TMP_DIR)
LOG ||= OrbLogger::OrbLogger.new
LOG.progname = 'Rake Tasks'

def timestamp
  Time.now.strftime('%Y%m%d_%H%M%S')
end

def build_rspec_opts(test_type, task)
  task.rspec_opts = ['-c']
  task.rspec_opts << '--require' << 'fuubar'
  task.rspec_opts << '--format' << Fuubar
  task.rspec_opts << '--require' << 'rspec-extra-formatters'
  task.rspec_opts << '--format' << JUnitFormatter
  task.rspec_opts << '--out' << "#{TMP_DIR}/results/#{test_type}/#{timestamp}_results.xml"
  task.rspec_opts << '--format' << 'html'
  task.rspec_opts << '--out' << "#{TMP_DIR}/results/#{test_type}/#{timestamp}_results.html"
  task.pattern = "spec/#{test_type}/**/*_spec.rb"
end

def delete_dir_with_output(dir_name)
  LOG.info("Deleting the #{dir_name} directory...")
  yield
  LOG.info('Deleted.')
end

def delete_tmp_directory(dir_name)
  tmp_dir = File.join(TMP_DIR, dir_name)
  delete_dir_with_output(tmp_dir) do
    FileUtils.rm_rf(tmp_dir) # TODO: why is this not deleting?
  end
end

namespace :clobber do
  desc "Removing #{Constants::SANDBOX}"
  task :e2e do
    delete_dir_with_output(Constants::SANDBOX) do
      FileUtils.rm_rf(Constants::SANDBOX)
    end
  end

  desc 'Remove Simplecov files'
  task :coverage do
    delete_tmp_directory('coverage')
  end

  desc 'Remove ALL Tmp files'
  task :tmp do
    delete_dir_with_output(TMP_DIR) do
      FileUtils.rm_rf(TMP_DIR)
    end
  end

  desc 'Remove Unit Test Results files'
  task :unit do
    delete_tmp_directory(File.join('results', 'unit'))
  end
end

namespace :spec do
  RSpec::Core::RakeTask.new(unit: %w(clobber:tmp)) do |task|
    build_rspec_opts('unit', task)
  end

  RSpec::Core::RakeTask.new(e2e: %w(clobber:tmp clobber:e2e)) do |task|
    LOG.info("Creating new #{Constants::SANDBOX}")
    FileUtils.mkdir_p(Constants::SANDBOX)
    build_rspec_opts('e2e', task)
  end

  desc 'Run all tests'
  task full: %w(spec:unit spec:e2e)
end

YARD::Rake::YardocTask.new do |task|
  task.options = ['--output-dir=tmp/yard']
end

desc 'Run RuboCop on lib and spec directories, Gemfile, gemspec, Rakefile; Override with a space delimited list'
RuboCop::RakeTask.new(:rubocop, :pattern) do |task, args|
  task.patterns = ['lib/**/*.rb', 'spec/**/*.rb', 'Gemfile', '*.gemspec', 'Rakefile']
  task.patterns = args[:pattern].split(' ') if args[:pattern] # override default pattern
  LOG.info("Running RuboCop against #{task.patterns}")
  # don't abort rake on failure
  task.fail_on_error = false
end

desc 'Open latest unit test results in your yer browser'
task :open_unit_results do
  file = `find tmp/results/unit/ -regex ".*\.\html" | tail -1`
  `open #{file}`
end
