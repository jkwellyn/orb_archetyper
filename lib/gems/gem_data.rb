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
      if @version.nil?
        ''
      else
        ", '#{@range_specifier} #{@version}'"
      end
    end
  end
end
