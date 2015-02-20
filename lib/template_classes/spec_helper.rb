require_relative 'base'

class TemplateSpecHelper < Template
  def template_file
    'spec_helper.erb'
  end

  def output_directory
    File.join(project_name, 'spec')
  end

  def output_file
    'spec_helper.rb'
  end
end
