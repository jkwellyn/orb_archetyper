require_relative 'base'

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
      .rvmrc
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
      temp
      tmp
      vendor
      *.log
      annotations.yml
      annotations_report.html
    )
  end
end
