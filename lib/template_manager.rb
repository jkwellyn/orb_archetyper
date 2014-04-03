require_relative 'orb-archetyper/version'
require 'date'
require 'erb'

# Data Structure to hold the supported project archetypes available: consisting of the project types, files and folders required.
# In addition any dynamic substitutins that are required when the files are created.
class TemplateManager
  @@types = [:cli,:core,:test,:utility]
	# Create a new Templater Manager
  # Project Name and Module name
  def initialize(pname, mname)

    @pname = pname
    @mname = mname

    @user = ENV['USER']

    @archetypes = {
      :cli    => [:binf, :build, :gemfile, :gemspec, :gitignore, :libf, :metrics, :rake, :readme, :spec_dot, :spec_help, :unit, :resources, :rubocop, :version],
      :core   => [:build, :coverage, :gemfile, :gemspec, :gitignore, :libf, :metrics, :rake, :readme, :spec_dot, :spec_help, :unit, :rubocop, :version],
      :test   => [:build, :config, :coverage, :gemfile, :gemlock, :gitignore, :logs, :rake, :readme, :resources, :results, :rvmrc, :spec_dot, :accept, :spec_help, :lib, :version],
      :utility=> [:build, :config, :coverage, :gemfile, :gemspec, :gitignore, :libf, :metrics, :rake, :readme, :spec_dot, :spec_help, :unit, :version],
    }

      #not all folders have child files
    @folders = {
        :base =>      "#{@pname}",
        :binf =>      "bin",
        :config =>    "config",
        :lib =>       "lib", #this is the lib folder
        :libf =>      "lib", #this is the main lib rb file
        :resources => "resources",
        :spec =>      "spec",
        :unit =>      "spec/unit", #unit tests
        :accept =>    "spec/accept", #functional
        :version =>   "lib/#{pname}"
    };

  # {target directory, src directory, filename]
   @files = {
      :binf      => [@folders[:binf],   "templates/bin_cli.txt",      "#{@pname}"],
      :build     => [@folders[:base],   "templates/build.txt",        "#{@pname}.bash"],
      :config    => [@folders[:config], "templates/env_config.yml",   "env_config.yml"],
      :gitignore => [@folders[:base],   "templates/dot_gitignore.txt",".gitignore"],
      :gemfile   => [@folders[:base],   "templates/gemfile.erb",      "Gemfile"],
      :gemspec   => [@folders[:base],   "templates/gemspec.erb",      "#{@pname}.gemspec"],
      :gemlock   => [@folders[:base],   "templates/gemlock.txt",      "Gemfile.lock"],
      :libf      => [@folders[:libf],   "templates/main.txt",         "#{@pname}.rb"],
      :licence   => [@folders[:base],   "templates/licence.txt",      "LICENCE"],
      :metrics   => [@folders[:base],   "templates/dot_metrics.txt",  ".metrics"],
      :rubocop   => [@folders[:base],   "templates/dot_rubocop.txt",  ".rubocop.yml"],
      :rake      => [@folders[:base],   "templates/rake.txt",         "Rakefile"],
      :readme    => [@folders[:base],   "templates/readme.txt",       "README.md"],
      :rvmrc     => [@folders[:base],   "templates/dot_rvmrc.txt",    ".rvmrc"],
      :spec_help => [@folders[:spec],   "templates/spec_help.txt",    "spec_helper.rb"],
      :spec_dot  => [@folders[:base],   "templates/spec_dot.txt",     ".rspec"],
      :unit      => [@folders[:unit],   "templates/spec_test.txt",    "#{@pname}_test.rb"],
      :accept    => [@folders[:accept], "templates/spec_test.txt",    "#{@pname}_test.rb"],
      :version   => [@folders[:version],"templates/version.txt",      "version.rb"]
    }

    @substitutes = {
      :gemspec => {:module_name   => ["{module_name}",    "#{@mname}"],
                   :username      => ["{username}",        @user],
                   :project_name  => ["{project_name}",   "#{@pname}"]},
      :gemfile => {:project_name  => ["{project_name}",   "#{@pname}"]},
      :licence => {:holder_name   => ["{copyright_holder}", @user],
                  :year           => ["{year}",            Date.today.strftime("%Y")]},
      :readme  => {:project_name  => ["{project_name}",   "#{@pname}"]},
      :rake    => {:project_name  => ["{project_name}",   "#{@pname}"]},
      :version => {:orb_version   => ["{version}",         OrbArchetyper::VERSION],
                   :module_name   => ["{module_name}",    "#{@mname}"]},
      :libf    => {:module_name   => ["{module_name}",    "#{@mname}"],
                   :project_name  => ["{project_name}",   "#{@pname}"]},
      :binf    =>  {:module_name  => ["{module_name}",    "#{@mname}"],
                   :project_name  => ["{project_name}",   "#{@pname}"]},
      :unit    => {:project_name  => ["{project_name}",   "#{@pname}"],
                    :module_name  => ["{module_name}",    "#{@mname}"]},
      :accept   => {:project_name  => ["{project_name}",   "#{@pname}"],
                    :module_name  => ["{module_name}",    "#{@mname}"]}
    }
  end

  def self.archetypes
    @archetypes
  end

	def archetypes
		@archetypes
	end

	def folders
    @folders
	end

	def files
		@files
	end

	def substitutes
		@substitutes
  end

  def subtypes
      (@files.keys + @folders.keys).uniq.sort
	end

  def self.types
    @@types
  end
end