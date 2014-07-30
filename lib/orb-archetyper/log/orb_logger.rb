require 'logger'
require_relative 'multi_io'
# Logger that supports STDOUT and a logfile
# Logger init as log level info

module OrbArchetyper
  module Log
    class OrbLogger
      attr_reader :logger

      def initialize
        log_file = File.open('tmp/logfile.log', 'a')
        @logger = Logger.new MultiIO.new(STDOUT, log_file)

        # TODO : this is set by default here but should be moved to be a config file
        @logger.level = Logger::INFO
        @logger.info('Logging initialized in spec_help.rb')
      end
    end
  end
end
