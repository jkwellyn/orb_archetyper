module Gems
  class GemData
    attr_accessor :name, :range_specifier, :version

    def initialize(name, range_specifier = '', version = nil)
      @name            = "'#{name}'"
      @range_specifier = range_specifier
      @version         = version
    end

    def gemfile_entry
      name + version_string
    end

    def version_string
      version ? ", '#{range_specifier} #{version}'" : ''
    end
  end
end
