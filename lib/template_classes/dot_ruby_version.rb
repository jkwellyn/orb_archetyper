require_relative 'base'

class TemplateDotRubyVersion < Template
  def template_file
    'dot_ruby_version.erb'
  end

  def output_file
    '.ruby-version'
  end
end
