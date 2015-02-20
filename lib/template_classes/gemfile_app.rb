require_relative 'base'
require_relative '../projects/base'
require_relative '../gems/gem_data'

class TemplateGemfileApp < Template
  def template_file
    'gemfile_app.erb'
  end

  def output_file
    'Gemfile'
  end

  def gem_data
    gems = []
    gems += template_data[:dev_gems] if template_data[:dev_gems]
    gems += template_data[:runtime_gems] if template_data[:runtime_gems]
    gems.map { |gem| Gems::GemData.new(*gem) }
  end
end
