#!/usr/bin/env rake
require 'rspec/core/rake_task'
require 'rspec-extra-formatters'
require 'rspec/core'

RSpec::Core::RakeTask.new(:rspec) do |t|
  t.rspec_opts = ['-c']
  t.rspec_opts << '-r' << 'rspec-extra-formatters'
  t.rspec_opts << '-o' << "results/"+ Time.now.strftime("%Y%m%d%H%M%S") + ".xml"
  t.rspec_opts << '-f' << JUnitFormatter
  t.rspec_opts << '-o' << 'results/rspec-extra-formatter-results.html'
  t.rspec_opts << '-f' << 'html'
  t.pattern = 'test/**/*test.rb'
end

# TODO rake tasks to clobber results directory


=begin
require 'rdoc/task'

 RDoc::Task.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = 'orb-archetyper'
  rdoc.main = 'README.rdoc'
  rdoc.rdoc_files.include('README*', 'lib/**/*.rb')
end
#=end


	
