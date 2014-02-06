require 'date'

class TemplateManager
	
  def initialize(pname)

    @pname = pname

    @archetypes = {
      :cli    => [:binf, :gemfile, :gemspec, :gitignore, :libf, :logs, :rake, :readme, :resources, :rdoc, :test, :coverage, :version], 
      :core   => [:coverage, :gemfile, :gemspec, :gitignore, :libf, :rake, :rdoc, :readme, :test, :version], 
      :test   => [:config, :coverage, :gemfile, :gemlock, :gitignore, :libf, :logs, :rake, :readme, :resources, :results, :rvmrc, :test, :spec],
      :utility=> [:config, :coverage, :gemfile, :gemspec, :gitignore, :libf, :rake, :rdoc, :readme, :test, :version],
    }

      #not all folders have child files
    @folders = {
        :base => "#{@pname}",
        :binf => "bin",
        :coverage => "coverage",
        :config => "config",   
        :libf => "lib",
        :logs => "logs",
        :rdoc => "rdoc",
        :resources => "resources",
        :results =>"results",
        :spec => "spec", #functional tests #TODO add subdirs here for test categories e.g SMOKE SANITY PRIORITY SECONDARY TERTIARY
        :test => "test" #unit tests folders    
    };


  # {target directory, src directory, filename]
   @files = {
      :binf      => [@folders[:binf],   "../templates/bin_cli.txt",      "#{@pname}"],
      :config    => [@folders[:config], "../templates/env_config.yml",   "env_config.yml"], 
      :gitignore => [@folders[:base],   "../templates/dot_gitignore.txt",".gitignore"],
      :gemfile   => [@folders[:base],   "../templates/gemfile.txt",      "Gemfile"],
      :gemspec   => [@folders[:base],   "../templates/gemspec.txt",      "#{@pname}.gemspec"],
      :gemlock   => [@folders[:base],   "../templates/gemlock.txt",      "Gemfile.lock"],
      :libf      => [@folders[:libf],   "../templates/main.txt",         "#{@pname}.rb"],
      :licence   => [@folders[:base],   "../templates/licence.txt",      "LICENCE"],
      :rake      => [@folders[:base],   "../templates/rake.txt",         "Rakefile"],
      :readme    => [@folders[:base],   "../templates/readme.txt",       "README.md"],
      :rvmrc     => [@folders[:base],   "../templates/dot_rvmrc.txt",    ".rvmrc"],
      :spec      => [@folders[:spec],   "../templates/spec.txt",         "#{@pname}_spec.rb"],
      :test      => [@folders[:test],   "../templates/test.txt",         "#{@pname}_test.rb"],
      :version   => [@folders[:libf]+"/#{@pname}", "../templates/version.txt", "version.rb"]
    }

    @substitutes = {
      :gemspec => {:username      => ["{username}",       ENV['USER'] ],
                   :project_name  => ["{project_name}",   "#{@pname}"]},
      :gemfile => {:project_name  => ["{project_name}",   "#{@pname}"]},
      :licence => {:holder_name   => ["{copyright_holder}", ENV['USER']       ],
                  :year           => ["{year}",            Date.today.strftime("%Y")]},
      :readme  => {:project_name  => ["{project_name}",   "#{@pname}"]},
      :rake    => {:project_name  => ["{project_name}",   "#{@pname}"]},
      :version => {:module_name   => ["{module_name}",    "#{@pname}".capitalize]},
      :libf    => {:module_name   => ["{module_name}",    "#{@pname}".capitalize],
                   :project_name  => ["{project_name}",   "#{@pname}"]},
      :binf    => {:project_name  => ["{project_name}",   "#{@pname}"]},
      :spec    => {:project_name  => ["{project_name}",   "#{@pname}"]},
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
  
  #TODO use to validate in generator
  def subtypes
      (@files.keys + @folders.keys).uniq.sort
	end

#!EOF	
end
