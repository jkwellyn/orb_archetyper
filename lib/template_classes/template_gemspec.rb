require_relative 'template'
require_relative '../../lib/projects/project_gem'
require_relative '../../lib/gems/gem_data'

class TemplateGemspec < Template
  def template_file
    'gemspec.erb'
  end

  def output_file
    "#{@project_name}.gemspec"
  end

  def gem_data
    @template_data[:gems].map { |gem| Gems::GemData.new(*gem) }
  end

  def version_path
    @template_data[:version_path]
  end
end
