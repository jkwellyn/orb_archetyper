# output logs to both console and STDOUT
# TODO : It would be cool to give this the moon-raker treatment ED
module OrbArchetyper
  module Log
    # Support multi formats with the logger
    class MultiIO
      def initialize(*targets)
        @targets = targets
      end

      def write(*args)
        @targets.each { |t| t.write(*args) }
      end

      def close
        @targets.each(&:close)
      end
    end
  end
end
