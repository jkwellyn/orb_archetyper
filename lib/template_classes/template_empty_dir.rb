require_relative 'template'

class TemplateEmptyDir < Template
  def output_directory
    File.join(@project_name, @template_data[:directory_name])
  end

  def create
    File.join(FileUtils.mkdir_p(output_directory))
  end
end
