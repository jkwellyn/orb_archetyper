require_relative 'template'

class TemplateOrbAnnotationsMustache < Template
  def template_file
    'orb_annotations_mustache.erb'
  end

  def output_file
    'orb_annotations.mustache'
  end
end
