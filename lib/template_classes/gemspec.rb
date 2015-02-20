require_relative 'base'
require_relative '../projects/gem'
require_relative '../gems/gem_data'

class TemplateGemspec < Template
  def template_file
    'gemspec.erb'
  end

  def output_file
    "#{project_name}.gemspec"
  end

  def dev_gem_data
    if template_data[:dev_gems]
      template_data[:dev_gems].map { |gem| Gems::GemData.new(*gem) }
    else
      []
    end
  end

  def runtime_gem_data
    if template_data[:runtime_gems]
      template_data[:runtime_gems].map { |gem| Gems::GemData.new(*gem) }
    else
      []
    end
  end

  def version_path
    template_data[:version_path]
  end
end
