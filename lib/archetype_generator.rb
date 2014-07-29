require_relative 'helpers/file_utils'
require_relative 'projects/project_factory'
require 'ansi'
require 'erb'
require 'github_project/project'
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
    project_archetype = Projects::ProjectFactory.make_project(
      options[:type],
      options[:project],
      options[:include],
      options[:exclude]
    )
    project_archetype.generate_project

    unless options[:no_github]
      SharedTasks::GithubProject::Project.initialize_git(@project_name)
      puts "\t" + ANSI.green{'initialized git repository'}
    end

    project_dir = options[:project]
    if options[:upload_organization]
      github_organization = options[:upload_organization]
      upload_to_github(project_dir) do |github_project|
        github_project.create_remote_repository(github_organization)
        github_project.push(github_organization)
        github_project.fork_repository(github_organization)
      end

    elsif options[:upload_user]
      upload_to_github(project_dir) do |project|
        project.create_user_repository
        project.push
      end
    end
  end

  private

  def upload_to_github(project_dir, &block)
    Dir.chdir(project_dir) do
      github_project = SharedTasks::GithubProject::Project.new
      github_project.commit_current_directory('Initial commit of auto-generated scaffolding.')
      yield(github_project)
    end
  end

# TODO use active_support/inflector here?
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
