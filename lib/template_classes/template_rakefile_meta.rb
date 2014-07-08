require_relative 'template'

class TemplateRakefileMeta < Template

  def template_file
    'rakefile_meta.erb'
  end

  def output_file
    'Rakefile'
  end

end