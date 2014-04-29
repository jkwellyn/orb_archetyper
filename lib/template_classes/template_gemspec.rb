require_relative 'template'
require_relative '../../lib/projects/project_gem'
require_relative '../../lib/gems/gem_data'

class TemplateGemspec < Template

  def template_file
    'gemspec.erb'
  end

  def output_file
    "#@project_name.gemspec"
  end

  def gem_data
    # TODO change this so the templates don't know about the Projects.
    Projects::ProjectGem.gems.map{|gem| Gems::GemData.new(*gem)}
  end

end