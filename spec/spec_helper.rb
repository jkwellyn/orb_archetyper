require 'simplecov'

SimpleCov.start do
	coverage_dir 'tmp/coverage/unit'
  add_filter 'tmp/'
	add_filter 'spec/'
  add_filter 'resources/'
end	

RSpec.configure do |config|
  # Only accept expect syntax do not allow old should syntax
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

#output logs to both console and STDOUT
# TODO : It would be cool to give this the moon-raker treatment ED
require 'logger'

# Support multi formats with the logger
class MultiIO
  def initialize(*targets)
    @targets = targets
  end

  def write(*args)
    @targets.each {|t| t.write(*args)}
  end

  def close
    @targets.each(&:close)
  end
end

# Logger that supports STDOUT and a logfile
# Logger init as log level info
class OrbLogger
  attr_reader :logger
  
  def initialize
    log_file = File.open('tmp/logfile.log', 'a')
    @logger = Logger.new MultiIO.new(STDOUT, log_file)
    
    # TODO : this is set by default here but should be moved to be a config file
    @logger.level = Logger::INFO
    @logger.info("Logging initialized in spec_help.rb")
  end
end