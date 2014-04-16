require_relative 'helpers/file_utils'
require_relative 'template_manager'
require 'ansi'
require 'erb'

require 'ostruct'

class ERBValues < OpenStruct
  def render(template)
    ERB.new(template, nil, '-').result(binding)
  end
end

# Archetype generator
class ArchetypeGenerator
  # Create new generator instance given a project name
  # Project name is validated

  PROJECT_NAME_MIN_LENGTH = 2
  PROJECT_NAME_MAX_LENGTH = 30
  PROJECT_NAME_INVALID_LENGTH_ERROR = "Invalid Project Name Error. Project Name is either: nil or of incorrect length."
  PROJECT_NAME_INVALID_CHARACTERS_ERROR = "Invalid Project Name: should only contain a-z, 0-9, -,_"

  attr_reader :project_name, :module_name


  def initialize(project_name)
    # sanitize project name
    @project_name = sanitize(project_name)
    # generate valid module name
    @module_name = @project_name.split(/[_\-]/).map(&:capitalize).join

    templater = TemplateManager.new(@project_name, @module_name)

    @project_type_to_project_contents = templater.project_type_to_file_types
    @file_type_to_path = templater.file_type_to_path
    @file_type_to_template_data = templater.file_type_to_template_data
    @file_type_to_template_variables = templater.file_type_to_template_variables

  end

  # Create the required archetpe based on a hash
  def generate(options)

    project_contents = @project_type_to_project_contents[options[:type]]

    # OPTIMIZE: MERGE INCLUDE/EXCLUDE FUNCTIONALITY
    # handle include
    if options.key?(:include)
      options[:include].each do |desired_project_feature|
        unless project_contents.include?(desired_project_feature.to_sym)
          project_contents.push(desired_project_feature.to_sym)
              puts "\t" + ANSI.green{"Included"} + " #{desired_project_feature} into #{options[:type]} archetype."
        end
      end
    end

    # handle exclude
    if options.key?(:exclude)
      options[:exclude].each do |objectionable_project_feature|
        if project_contents.include?(objectionable_project_feature.to_sym)
          project_contents.delete(objectionable_project_feature.to_sym)
           #TODO: ADD THIS TO THE LOGGER
              puts "\t" + ANSI.red{"Excluded"} + " #{objectionable_project_feature} from #{options[:type]} archetype."
        end
      end
    end

    # generate base dir folder
      if Dir.exists?(@project_name)
        raise "Error. Directory already exists: #{@project_name}"
      end
    FileUtility.dir_creator(@project_name)

    # create any empty folders
    (@file_type_to_path.keys - @file_type_to_template_data.keys).each do |file_type|
      if project_contents.include? file_type and file_type != :base
        path = File.join(@project_name, @file_type_to_path[file_type])
        FileUtility.dir_creator(path)
      end
     end

    included_file_types_and_templates = @file_type_to_template_data.select do |file_type, _|
      project_contents.include? file_type
    end

    generate_files(options[:type],  included_file_types_and_templates)

    # Add to the repo
    if options[:github]
      git_initter
    end
  end

  # Given a hash of @files
  def generate_files(project_type, archetype)

    archetype.each do |file_type, template_data|

      target, src, file_name = template_data

      dir = File.dirname(File.expand_path(__FILE__))
      path = File.join(dir, "/" + src)

      unless File.exist?(path)
        raise "Cannot find the template file: #{path}"
      end

      if File.extname(path) == '.erb' # it's an erb!
        @file_type_to_template_variables[:dir] = dir
        @file_type_to_template_variables[:project_type] = project_type # add in project type that is used in conditionals
        erb_template = ERBValues.new(@file_type_to_template_variables)
        file_contents = erb_template.render(File.read(path))
      else
        file_contents = File.read(path)

        # handle dynamic subs
        #TODO add test for template insertion. This looks broken.
        if @file_type_to_template_variables.key?(file_type)
            @file_type_to_template_variables[file_type].values.each do |template_variable, value|
              file_contents.gsub!(template_variable, value)
            end
        end
      end

      if target != @project_name
        target = "#{@project_name}/#{target}"
        unless Dir.exists?(target)
          FileUtility.dir_creator(target)
        end
      end

      FileUtility.file_creator(target, file_name, file_contents)
    end
  end

  # Create git init project files
  # git ignore is created as part of the base archetype
  def git_initter

    unless File.exists?(File.join(@project_name,".git"))
      gitinnit = `git init "#{@project_name}"`
      puts "\t" + ANSI.green{"#{gitinnit}"}
    else
      raise "Unable to create git repo."
    end
  end

  # Ensure that the project name is valid
  def sanitize(projectName)

    if (projectName == nil or projectName.length < PROJECT_NAME_MIN_LENGTH or projectName.length > PROJECT_NAME_MAX_LENGTH)
      raise PROJECT_NAME_INVALID_LENGTH_ERROR
    end
    projectName = projectName.gsub(/\s/, "_")

    if (/^[\w_\-]+$/.match(projectName).nil?)
      raise PROJECT_NAME_INVALID_CHARACTERS_ERROR
    else
      return projectName
    end
  end
end