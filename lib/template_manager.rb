require_relative 'orb-archetyper/version'
require 'date'
require 'erb'

# Data Structure to hold the supported project archetypes available: consisting of the project types, files and folders required.
# In addition any dynamic substitutins that are required when the files are created.
class TemplateManager
  @@types = [:cli,:core,:test,:utility]
	# Create a new Templater Manager
  # Project Name and Module name
  def initialize(project_name, module_name)

    @project_name = project_name
    @module_name = module_name

    @user = ENV['USER']

    @project_type_to_project_contents = {
      :cli    => [:binf, :build, :gemfile, :gemspec, :gitignore, :libf, :metrics, :rake, :readme, :spec_dot, :spec_help, :tasks, :unit, :resources, :rubocop, :version],
      :core   => [:build, :gemfile, :gemspec, :gitignore, :libf, :metrics, :rake, :readme, :spec_dot, :spec_help, :tasks, :unit, :rubocop, :version],
      :test   => [:build, :config, :gemfile, :gemlock, :gitignore, :logs, :rake, :readme, :resources, :rvmrc, :spec_dot, :tasks, :spec, :accept, :acceptf, :smoke, :sanity, :primary, :secondary, :spec_help, :lib, :version],
      :utility=> [:build, :config, :gemfile, :gemspec, :gitignore, :libf, :metrics, :rake, :readme, :spec_dot, :spec_help, :unit, :version],
    }

      #not all folders have child files
    @file_type_to_path = {
        :base =>      "#{@project_name}",
        :binf =>      "bin",
        :config =>    "config",
        :lib =>       "lib", #this is the lib folder
        :libf =>      "lib", #this is the main lib rb file
        :resources => "resources",
        :spec =>      "spec",
        :unit =>      "spec/unit", #unit tests
        :accept =>    "spec/accept", #functional
        :smoke =>     "spec/accept/smoke",
        :sanity =>    "spec/accept/sanity",
        :primary =>   "spec/accept/primary",
        :secondary => "spec/accept/secondary",
        :version =>   "lib/#{@project_name}"
    };

  # {target directory, src directory, filename]
   @file_type_to_template_data = {
      :binf      => [@file_type_to_path[:binf],   "templates/bin_cli.txt",      "#{@project_name}"],
      :build     => [@file_type_to_path[:base],   "templates/build.txt",        "build.bash"],
      :config    => [@file_type_to_path[:config], "templates/env_config.yml",   "env_config.yml"],
      :gitignore => [@file_type_to_path[:base],   "templates/dot_gitignore.txt",".gitignore"],
      :gemfile   => [@file_type_to_path[:base],   "templates/gemfile.erb",      "Gemfile"],
      :gemspec   => [@file_type_to_path[:base],   "templates/gemspec.erb",      "#{@project_name}.gemspec"],
      :gemlock   => [@file_type_to_path[:base],   "templates/gemlock.txt",      "Gemfile.lock"],
      :libf      => [@file_type_to_path[:libf],   "templates/main.txt",         "#{@project_name}.rb"],
      :licence   => [@file_type_to_path[:base],   "templates/licence.txt",      "LICENCE"],
      :metrics   => [@file_type_to_path[:base],   "templates/dot_metrics.txt",  ".metrics"],
      :rubocop   => [@file_type_to_path[:base],   "templates/dot_rubocop.txt",  ".rubocop.yml"],
      :rake      => [@file_type_to_path[:base],   "templates/rake.txt",         "Rakefile"],
      :tasks     => [@file_type_to_path[:libf],  "templates/tasks.erb",        "tasks.rb"],
      :readme    => [@file_type_to_path[:base],   "templates/readme.txt",       "README.md"],
      :rvmrc     => [@file_type_to_path[:base],   "templates/dot_rvmrc.txt",    ".rvmrc"],
      :spec_help => [@file_type_to_path[:spec],   "templates/spec_help.txt",    "spec_helper.rb"],
      :spec_dot  => [@file_type_to_path[:base],   "templates/spec_dot.txt",     ".rspec"],
      :unit      => [@file_type_to_path[:unit],   "templates/spec_test.txt",    "#{@project_name}_test.rb"],
      :acceptf   => [@file_type_to_path[:accept], "templates/spec_test.txt",    "#{@project_name}_test.rb"],
      :version   => [@file_type_to_path[:version],"templates/version.txt",      "version.rb"]
    }

    @file_type_to_template_variables = {
      :gemspec => {:module_name   => ["{module_name}",    "#{@module_name}"],
                   :username      => ["{username}",        @user],
                   :project_name  => ["{project_name}",   "#{@project_name}"]},
      :gemfile => {:project_name  => ["{project_name}",   "#{@project_name}"]},
      :licence => {:holder_name   => ["{copyright_holder}", @user],
                  :year           => ["{year}",            Date.today.strftime("%Y")]},
      :readme  => {:project_name  => ["{project_name}",   "#{@project_name}"]},
      :rake    => {:project_name  => ["{project_name}",   "#{@project_name}"]},
      :version => {:orb_version   => ["{version}",         OrbArchetyper::VERSION],
                   :module_name   => ["{module_name}",    "#{@module_name}"]},
      :libf    => {:module_name   => ["{module_name}",    "#{@module_name}"],
                   :project_name  => ["{project_name}",   "#{@project_name}"]},
      :binf    =>  {:module_name  => ["{module_name}",    "#{@module_name}"],
                   :project_name  => ["{project_name}",   "#{@project_name}"]},
      :unit    => {:project_name  => ["{project_name}",   "#{@project_name}"],
                    :module_name  => ["{module_name}",    "#{@module_name}"]},
      :acceptf => {:project_name  => ["{project_name}",   "#{@project_name}"],
                    :module_name  => ["{module_name}",    "#{@module_name}"]}
    }
  end

	def project_type_to_file_types
		@project_type_to_project_contents
	end

	def file_type_to_path
    @file_type_to_path
	end

	def file_type_to_template_data
		@file_type_to_template_data
	end

	def file_type_to_template_variables
		@file_type_to_template_variables
  end

  def subtypes
      (@file_type_to_template_data.keys + @file_type_to_path.keys).uniq.sort
	end

  def self.types
    @@types
  end
end