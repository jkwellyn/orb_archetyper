#!/usr/bin/env rake
require 'rspec/core/rake_task'
require 'rspec-extra-formatters'
require 'rspec/core'
require 'rubocop/rake_task'
require 'rdoc/task'
require 'annotation_manager/rake_task'
require 'metric_fu'
require 'fuubar'
require 'logger'
require_relative 'orb-archetyper/constants'
require_relative 'orb-archetyper/log/orb_logger'

LOG = OrbArchetyper::Log::OrbLogger.new.logger

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
  task.pattern = "spec/#{test_type}/**/*_spec.rb"
end

def delete_dir_with_output(dir_name)
  LOG.info("Deleting the #{dir_name} directory...")
  yield
  LOG.info("Deleted.")
end

def delete_tmp_directory(dir_name)
  tmp_dir = File.join('tmp', dir_name)
  delete_dir_with_output(tmp_dir) do
    FileUtils.rm_rf(tmp_dir) #TODO why is this not deleting?
  end
end

namespace :clobber do

  desc "Removing #{Constants::SANDBOX}"
  task :e2e do
    delete_dir_with_output(Constants::SANDBOX) do
      FileUtils.rm_rf(Constants::SANDBOX)
    end
  end

  desc "Remove Simplecov files"
  task :coverage do
    delete_tmp_directory('coverage')
  end

  desc "Remove ALL Tmp files"
  task :tmp do
    delete_dir_with_output('tmp') do
      FileUtils.rm_rf('tmp')
    end
  end

  desc "Remove Unit Test Results files"
  task :unit do
    delete_tmp_directory(File.join('results', 'unit'))
  end

  desc "Remove metrics results files"
  task :metrics do
    delete_tmp_directory('metric_fu')
  end
end

namespace :spec do
  RSpec::Core::RakeTask.new(:unit => %w{clobber:tmp}) do |task|
    build_rspec_opts('unit', task)
  end

  RSpec::Core::RakeTask.new(:e2e => %w{clobber:tmp clobber:e2e}) do |task|
    LOG.info("Creating new #{Constants::SANDBOX}")
    FileUtils.mkdir_p(Constants::SANDBOX)
    build_rspec_opts('e2e', task)
  end

  desc "Run all tests"
  task :full => %w{spec:unit spec:e2e}
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
