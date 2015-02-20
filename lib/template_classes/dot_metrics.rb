require_relative 'base'

class TemplateDotMetrics < Template
  def template_file
    'dot_metrics.erb'
  end

  def output_file
    '.metrics'
  end
end
