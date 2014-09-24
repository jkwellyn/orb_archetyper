require 'active_support/inflector'

module OrbArchetyper
  module Rules
    module NamingConventions
      module FileNames
        def apply_conventions(file_name)
          file_name.underscore
        end
      end
    end
  end
end
