require 'github_project/project'


class ForkGenerator

  # Fork an existing upstream project and create two remotes called 'upstream' and 'origin'.
  def generate(options)
    SharedTasks::GithubProject::Project.fork_upstream_repository(options[:fork])
  end
end
