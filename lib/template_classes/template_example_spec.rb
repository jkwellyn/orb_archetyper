require_relative 'template'

class TemplateExampleSpec < Template
  def template_file
    'example_spec.erb'
  end

  def output_file
    File.join("#{@project_name}_spec.rb")
  end

  def output_directory
    if @template_data[:test_directory]
      File.join(super, @template_data[:test_directory])
    else
      File.join("#{super}/spec/unit")
    end
  end
end
