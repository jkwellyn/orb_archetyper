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
    Projects::Project::GEMS.map{|gem| Gems::GemData.new(*gem)}
  end

end