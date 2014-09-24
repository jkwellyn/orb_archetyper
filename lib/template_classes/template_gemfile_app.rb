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
    gems = @template_data[:dev_gems] unless @template_data[:dev_gems].nil?
    gems += @template_data[:runtime_gems] unless @template_data[:runtime_gems].nil?
    gems.map { |gem| Gems::GemData.new(*gem) }
  end
end
