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
  attr_accessor :logger

  PROJECT_NAME_MIN_LENGTH = 2
  PROJECT_NAME_MAX_LENGTH = 30
  PROJECT_NAME_INVALID_LENGTH_ERROR = 'Invalid Project Name Error. Project Name is either: nil or of incorrect length.'
  PROJECT_NAME_INVALID_CHARACTERS_ERROR = 'Invalid Project Name: should only contain a-z, 0-9, -,_'

  # initialize logger
  # LOG = OrbLogger::OrbLogger.new

  attr_reader :project_name, :module_name

  def initialize(project_name)
    @project_name = sanitize(project_name)
    @logger = LOG || OrbLogger::OrbLogger.new
    @logger.progname = self.class
  end

  def generate(options)
    project_archetype = Projects::ProjectFactory.make_project(
      options[:type],
      @project_name
    )
    project_archetype.generate_project

    unless options[:no_github]
      SharedTasks::GithubProject::Project.initialize_git(@project_name)
      @logger.info ANSI.green { 'initialized git repository' }
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

  def upload_to_github(project_dir)
    Dir.chdir(project_dir) do
      github_project = SharedTasks::GithubProject::Project.new
      github_project.commit_current_directory('Initial commit of auto-generated scaffolding.')
      yield(github_project)
    end
  end

  # TODO: use active_support/inflector here?
  # Ensure that the project name is valid
  def sanitize(project_name)
    if project_name.nil? || project_name.length < PROJECT_NAME_MIN_LENGTH ||
        project_name.length > PROJECT_NAME_MAX_LENGTH
      fail PROJECT_NAME_INVALID_LENGTH_ERROR
    end
    project_name = project_name.underscore

    if /^[\w_\-]+$/.match(project_name).nil?
      fail PROJECT_NAME_INVALID_CHARACTERS_ERROR
    else
      project_name
    end
  end
end
