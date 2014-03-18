require 'optparse'
require_relative 'template_manager'
require_relative 'orb-archetyper/version'

# read options from command line and return as hash 
class OptionParser
	# Parse the command line args
	def self.parse(args)

		options = Hash.new 

		options[:github] = false
		
		opt_parser = OptionParser.new do |opts|
			opts.separator "\n"
			opts.banner = "Orb Archetype Generator:"
	
			opts.separator "Usage: orb-archetyper [OPTIONS]"
			opts.separator "Specific options:"

			# list of choices
			opts.on("-t", "--type [TYPE]", TemplateManager.types, 
				"Select project type (cli, core, utility, test).") do |t|
					options[:type] = t
			end 

			opts.on("-p", "--project [STRING]", "Specify the project name.") do |p|
				options[:project] = p
			end

			opts.separator ""
			opts.separator "Configuration options:"

			opts.on("-x", "--exclude x,y,z", Array, "Explicitly state the files/folders you wish to EXCLUDE from the archetype.") do |x|
				options[:exclude] = x
			end

			opts.on("-i", "--include x,y,z", Array, "Explicitly state the files/folders you wish to INCLUDE into the archetype.") do |i|
				options[:include] = i
			end

			# optional arguement, true if declared
			opts.on("-g", "--[no-]github", "Create the git repo for the project,", 
				"False if omitted, true if declared.") do |g|
					unless g.nil?
						options[:github] = g
					end
			end

			opts.separator ""
			opts.separator "Helper options:"

			# display file/folder components
			opts.on_tail("-e", "--expand", "Display file/folder choices.") do
		 		puts TemplateManager.new(options[:project],options[:project]).subtypes
		 		exit
			end

			# display version
			opts.on_tail("-v", "--version", "Display version") do
		 		puts OrbArchetyper::VERSION
		 		exit
			end

			# display help
			opts.on_tail("-h","--help", "Show help") do
		 		puts "For full documentation: https://github.va.opower.it/euan-davidson/orb-archetyper/blob/master/README.md"
		 		puts  opts
		 		exit
			end
		end
		
		opt_parser.parse(args)

		# raise an exception if we have not found a project name option or type is unsupported
		raise OptionParser::MissingArgument if options[:project].nil?
		raise OptionParser::InvalidArgument if options[:type].nil?

		return options
	end
end