#TODO: MOVE FILE HELPERS INTO GEM
require_relative 'helpers/file_utils'
require_relative 'template_manager'
require 'ansi'

# Archetype generator
class ArchetypeGenerator
  # Create new generator instance given a project name
  # Project name is validated
  def initialize(project_name)
    # sanitize project name
    @pname = sanitize(project_name)
    # generate valid module name
    @mname = @pname.split(/[_\-]/).map(&:capitalize).join

    templater = TemplateManager.new(@pname, @mname)

    @archetypes = templater.archetypes
    @folders = templater.folders
    @files = templater.files
    @substitutes = templater.substitutes

  end

  # Create the required archetpe based on a hash
  def generate(options)

    arch = @archetypes[options[:type]]

    # OPTIMIZE: MERGE INCLUDE/EXCLUDE FUNCTIONALITY
    # handle include
    if options.key?(:include)
      options[:include].each do |i|
        unless arch.include?(i.to_sym)
          arch.push(i.to_sym)
              puts "\t" + ANSI.green{"Included"} + " #{i} into #{options[:type]} archetype."
        end
      end
    end

    # handle exclude
    if options.key?(:exclude)
      options[:exclude].each do |x|
        if arch.include?(x.to_sym)
          arch.delete(x.to_sym)
           #TODO: ADD THIS TO THE LOGGER
              puts "\t" + ANSI.red{"Excluded"} + " #{x} from #{options[:type]} archetype."
        end
      end
    end

    # generate base dir folder
      if Dir.exists?(@pname)
        raise "Error. Directory already exists: #{dir_path}"
      end
    FileUtility.dir_creator(@pname)

    # create any empty folders
    (@folders.keys - @files.keys).each do |v|
      if arch.include? v and v!=:base
        folder_dir = File.join(@pname, v.to_s)
        FileUtility.dir_creator(folder_dir)
      end
     end

    # Generate files
    file_gen(@files.select{|key, value| arch.include? key} )

    # Add to the repo
    if options[:github]
      git_initter
    end
  end

  private
  # Given a hash of @files
  def file_gen(archetype)

    archetype.each do |key, value|

      target, src, fname = value

      fulldir = File.join(File.dirname(File.expand_path(__FILE__)), "/" + src)

      unless File.exist?(fulldir)
        raise "Cannot find the template file: #{fulldir}"
      end

      fdata = File.read(fulldir)

      # handle dynamic subs
      if @substitutes.key?(key)
          @substitutes[key].each do |k, v|
            fdata = fdata.gsub(v[0], v[1])
          end
      end

      if target != @pname
        target = "#{@pname}/#{target}"
        unless Dir.exists?(target)
          FileUtility.dir_creator(target)
        end
      end

     FileUtility.file_creator(target, fname, fdata)
    end
  end

  # Create git init project files
  # git ignore is created as part of the base archetype
  def git_initter

    unless File.exists?(File.join(@pname,".git"))
      gitinnit = `git init "#{@pname}"`
      puts "\t" + ANSI.green{"#{gitinnit}"}
    else
      raise "Unable to create git repo."
    end
  end

  private
  # Ensure that the project name is valid
  def sanitize(projectName)

    if (projectName == nil or projectName.length < 2 or projectName.length > 30)
      raise "Invalid Project Name Error. Project Name is either: nil or of incorrect length."
    end
    projectName = projectName.gsub(/\s/, "_")

    if (/^[\w_\-]+$/.match(projectName) != nil)
      return projectName
    else
      raise "Invalid Project Name: should only contain a-z, 0-9, -,_"
    end
  end
end