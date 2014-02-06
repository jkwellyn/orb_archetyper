#TODO move file helpers out to GEM
require_relative 'helpers/file_utils'
require_relative 'template_manager'
 
#Archetype generator
class ArchetypeGenerator

  #base directory is an optional arg
  def initialize(project_name, *base_directory)

    @pname = sanitize(project_name)

    if base_directory[0].nil?
      @bdir = @pname
    else
      @bdir = base_directory[0]
    end

    templater = TemplateManager.new(@pname)

    @archetypes = templater.archetypes
    @folders = templater.folders
    @files = templater.files
    @substitutes = templater.substitutes

  end 

  def generate(options)

    arch = @archetypes[options[:type]]

    #handle include
    if options.has_key?(:include)
      options[:include].each do |i|
        unless arch.include?(i.to_sym)
          arch.push(i.to_sym)
              puts "\t" + ANSI.green{"Included"} + " #{i} into #{options[:type]} archetype."
        end
      end
    end

    #handle exclude
    if options.has_key?(:exclude)
      options[:exclude].each do |x|
        if arch.include?(x.to_sym)
          arch.delete(x.to_sym)
           #TODO add this to the logger
              puts "\t" + ANSI.red{"Excluded"} + " #{x} from #{options[:type]} archetype."
        end
      end 
    end

    #generate folder
    #create base dir
    FileUtils.dir_creator(true, @pname)

    #create any empty folders
    (@folders.keys - @files.keys).each do |v|
      if arch.include? v and v!=:base 
       FileUtils.dir_creator(false, "#{@bdir}/#{v.to_s}")
      end
     end

    # Generate files
    file_gen(@files.select{|key, value| arch.include? key} )

    #Add to the repo
    if options[:github]
      raise "Unsupported operation exception: git creation not yet implemented."
    end
  end

  private
  #Given a hash of @files
  def file_gen(archetype)

    archetype.each do |key, value|

      target, src, fname = value

      fdata = File.read(src)

      #handle dynamic subs
      if @substitutes.has_key?(key) 
          @substitutes[key].each do |k, v|
            fdata = fdata.gsub(v[0], v[1])
          end 
      end

      if target != @pname
        target = "#{@bdir}/#{target}"
        FileUtils.dir_creator(false, target)
      end
    
     FileUtils.file_creator(target, fname, fdata)
    end
  end

  private
  #Ensure that the project name is valid
  def sanitize(projectName)

    if (projectName == nil or projectName.length < 2 or projectName.length > 30)
      raise "Error"
    end
    projectName = projectName.gsub(/\s/, "_")

    if (/^[\w_\-]+$/.match(projectName) != nil)
      return projectName
    end
    raise "Invalid Project Name: should only contain a-z, 0-9, -,_"
  end

end