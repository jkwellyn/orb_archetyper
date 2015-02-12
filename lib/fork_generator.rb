require 'github_project/project'

class ForkGenerator
  # Fork an existing upstream project and create two remotes called 'upstream' and 'origin'
  #
  # @param repo_name [String] Repo name with org prefix, e.g. opower/myproject
  def generate(repo_name)
    SharedTasks::GithubProject::Project.fork_upstream_repository(repo_name)
  end
end
