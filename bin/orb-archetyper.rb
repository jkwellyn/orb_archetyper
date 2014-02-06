#!/usr/bin/env ruby

require_relative '../lib/option_parser'
require_relative '../lib/archetype_generator'

begin

	options = OptionParser.parse(ARGV)

	generator = ArchetypeGenerator.new(options[:project], options[:directory])

	generator.generate(options)

end