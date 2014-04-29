require_relative 'template'
require_relative '../../lib/projects/project'
require_relative '../../lib/gems/gem_data'

class TemplateGemfileApp < Template

  def template_file
    'gemfile_app.erb'
  end

  def output_file
    'Gemfile'
  end

  def gem_data
    # TODO change this so the templates don't have to know about the projects
    Projects::Project.gems.map{|gem| Gems::GemData.new(*gem)}
  end

end