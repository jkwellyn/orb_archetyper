require_relative 'template'

class TemplateTasksTest < Template
  def test_types
    %w{smoke sanity primary secondary}
  end

  def output_file
    File.join('lib', 'tasks.rb')
  end

  def template_file
    'tasks_test.erb'
  end

  def partial_files
    %w{_tasks_reports.rb }
  end
end