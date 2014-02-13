#!/usr/bin/env rake
require 'rspec/core/rake_task'
require 'rspec-extra-formatters'
require 'rspec/core'

stamp = Time.now.strftime("%Y%m%d%H%M%S")

RSpec::Core::RakeTask.new(:rspec_unit) do |t|
  t.rspec_opts = ['-c']
  t.rspec_opts << '--require' << 'rspec-extra-formatters'
  t.rspec_opts << '--format' << JUnitFormatter
  t.rspec_opts << '--out' << "results/unit/#{stamp}_results.xml"
  t.rspec_opts << '--format' << 'html'
  t.rspec_opts << '--out' << "results/unit/#{stamp}_results.html"
  t.pattern = 'test/**/*test.rb'
end

# TODO rake tasks to clobber results, coverage, rdoc etc directories
require 'rake/clean'
#http://stackoverflow.com/questions/8812264/rake-delete-files-task
CLEAN = FileList['results/**/*']



	
