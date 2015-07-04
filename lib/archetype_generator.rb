require_relative 'helpers/file_utils'
require_relative 'projects/project_factory'
require 'ansi'
require 'erb'
require 'orb_github_project/project'
require 'ostruct'
require 'orb_logger'
require 'semver'

# Archetype generator
class ArchetypeGenerator
  # Create new generator instance given a project name
  # Project name is validated

  PROJECT_NAME_MIN_LENGTH = 2
  PROJECT_NAME_MAX_LENGTH = 140
  PROJECT_NAME_INVALID_LENGTH_ERROR     = 'Invalid Project Name Error. Project Name is either: nil or of incorrect length.'
  PROJECT_NAME_INVALID_CHARACTERS_ERROR = 'Invalid Project Name: should only contain a-z, 0-9, -,_'

  # initialize logger
  LOG ||= OrbLogger::OrbLogger.new

  attr_reader :project_name, :module_name

  # @param project_name [String] project name
  def initialize(project_name)
    @project_name = sanitize(project_name)
    LOG.progname = self.class.name
  end

  # @param options [Hash] options for project generation
  # @option options [String] :type Type of the project
  # @option options [String] :upload_organization Name of the Github organization to upload to
  # @option options [Boolean] :no_github `false` pushes the project to github, `true` does not
  def generate(options)
    project_archetype = Projects::ProjectFactory.make_project(
      project_name,
      options[:type] || :core,
      options[:upload_organization]
    )
    project_archetype.generate_project

    SharedTasks::OrbGithubProject::Project.initialize_git(project_name)
    LOG.info ANSI.green { 'initialized git repository' }

    return if options[:no_github]

    if (org = options[:upload_organization])
      upload_to_github(project_name) do |project|
        project.create_remote_repository(org)
        project.push(org)
        project.fork_repository(org)
      end
    else
      upload_to_github(project_name) do |project|
        project.create_user_repository
        project.push
      end
    end
  end

  private

  # @param project_dir [String] project directory
  def upload_to_github(project_dir)
    Dir.chdir(project_dir) do
      github_project = SharedTasks::OrbGithubProject::Project.new
      github_project.commit_current_directory('Initial commit of auto-generated scaffolding.')
      yield(github_project)
    end
  end

  # TODO: use active_support/inflector here?
  # Ensure that the project name is valid
  #
  # @param proj_name [String] project name
  def sanitize(proj_name)
    if proj_name.nil? ||
       proj_name.length < PROJECT_NAME_MIN_LENGTH ||
       proj_name.length > PROJECT_NAME_MAX_LENGTH
      fail PROJECT_NAME_INVALID_LENGTH_ERROR
    end
    proj_name = proj_name.underscore

    if /^[\w_\-]+$/.match(proj_name).nil?
      fail PROJECT_NAME_INVALID_CHARACTERS_ERROR
    else
      proj_name
    end
  end
end
