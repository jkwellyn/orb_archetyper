require_relative 'template'

class TemplateTasks < Template

  def template_file
    'tasks.erb'
  end

  def output_directory
    File.join(@project_name, 'lib')
  end

  def output_file
    'tasks.rb'
  end

  def partial_files
    %w{_tasks_reports.rb }
  end
end