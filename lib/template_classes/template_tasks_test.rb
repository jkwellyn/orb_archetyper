require_relative 'template'

class TemplateTasksTest < Template
  def test_types
    '%w(smoke sanity primary secondary)'
  end

  def file_pattern
    'spec/accept/#{task_name}/**/*_spec.rb'
  end

  def output_directory
    File.join(project_name, 'lib')
  end

  def output_file
    'tasks.rb'
  end

  def template_file
    'tasks_test.erb'
  end
end
