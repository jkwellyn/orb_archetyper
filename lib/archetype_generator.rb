require_relative 'helpers/file_utils'
require_relative 'projects/project_factory'
require 'ansi'
require 'erb'
require 'git'
require 'ostruct'

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
    @project_name = sanitize(project_name)
    #TODO use active_support/inflector here?
    @module_name = @project_name.split(/[_\-]/).map(&:capitalize).join
  end

  def generate(options)
    project = Projects::ProjectFactory.make_project(options[:type], options[:project], options[:include], options[:exclude])
    project.generate_project

    if options[:github]
      Git.init(@project_name)
      puts "\t" + ANSI.green{'initialized git repository'}
    end

  end

  #TODO use active_support/inflector here?
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