module Gems
  class GemData
    def initialize(name, range_specifier = '', version = nil)
      @name = "'#{name}'"
      @range_specifier = range_specifier
      @version = version
    end

    def gemfile_entry
      @name + version_string
    end

    def version_string
      return '' if @version.nil?
      return ", '#@range_specifier #@version'"
    end

  end
end