require 'optparse'
require_relative 'template_manager'
require_relative 'orb-archetyper/version'

# read options from command line and return as hash 
class OptionParser

	def self.parse(args)

		#TODO change to OStruct?
		options = Hash.new 

		options[:github] = false
		
		opt_parser = OptionParser.new do |opts|
			opts.separator ""
			opts.banner = "Orb Archetype Generator: [options]"
	
			opts.separator "Usage: orb-archetyper COMMAND [OPTIONS]"
			opts.separator "Specific options:"

			#list of choices
			opts.on("-t", "--type [TYPE]", [:cli, :core, :utility, :test], 
				"Select project type (cli, core, utility, test).") do |t|
					
					options[:type] = t
			end 

			opts.on("-p", "--project [STRING]", "Specify the project name.") do |p|
				options[:project] = p
			end

			opts.separator ""
			opts.separator "Optional options:"

			opts.on("-x", "--exclude x,y,z", Array, "Explicitly state the files/folders you wish to EXCLUDE from the archetype.") do |x|
				options[:exclude] = x
			end

			opts.on("-i", "--include x,y,z", Array, "Explicitly state the files/folders you wish to INCLUDE into the archetype.") do |i|
				options[:include] = i
			end

			opts.on("-d", "--directoy [STRING]", "Specify the target directoy, if not pwd.") do |d|
				options[:directory] = d
			end

			#optional arguement, true if declared
			opts.on("-g", "--[no-]github", "Create the git repo for the project,", 
				"False if omitted, true if declared.") do |g|
				options[:github] = g
			end

			opts.separator ""
			opts.separator "Common options:"

			#display file/folder components
			opts.on_tail("-e", "--expand", "Display file/folder choices.") do
		 		puts TemplateManager.new(options[:project]).subtypes
		 		exit
			end

			#display version
			opts.on_tail("-v", "--version", "Display version") do
		 		puts OrbArchetyper::VERSION
		 		exit
			end

			#display version
			opts.on_tail("-h","--help", "Show help") do
		 		puts  opts
		 		exit
			end
		end
		
		opt_parser.parse(args)
		return options
	end
end
