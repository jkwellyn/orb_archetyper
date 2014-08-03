require_relative 'template'

class TemplateTasksTest < Template
  def test_types
    %w(smoke sanity primary secondary)
  end

  def spec_tasks
    test_types.map { |test_type| "spec:#{test_type}" }.to_s.gsub("\"", "\'")
  end

  def output_directory
    File.join(@project_name, 'lib')
  end

  def output_file
    'tasks.rb'
  end

  def template_file
    'tasks_test.erb'
  end

  def partial_files
    %w(_tasks_reports.rb)
  end
end
