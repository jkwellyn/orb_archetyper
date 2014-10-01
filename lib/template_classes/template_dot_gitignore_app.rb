require_relative 'template'

class TemplateDotGitignoreApp < Template
  def template_file
    'dot_gitignore.erb'
  end

  def output_file
    '.gitignore'
  end

  def ignored_files
    %w(
      *.gem
      *.rbc
      .bundle
      .config
      .yardoc
      InstalledFiles
      _yardoc
      coverage
      doc/
      lib/bundler/man
      pkg
      rdoc
      spec/reports
      test/tmp
      test/version_tmp
      tmp
      vendor
      *.log
    )
  end
end
