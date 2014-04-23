require_relative 'template'
require_relative '../../lib/projects/project'
require_relative '../../lib/gems/gem_data'

class TemplateGemspec < Template

  def template_file
    'gemspec.erb'
  end

  def output_file
    "#@project_name.gemspec"
  end

  def gem_data
    Projects::Project::GEMS.map{|gem| Gems::GemData.new(*gem)}
  end

end