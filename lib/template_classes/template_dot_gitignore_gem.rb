require_relative 'template'

class TemplateDotGitignoreGem < Template
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
      Gemfile.lock
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
      annotations_report.html
      annotations.yml
    )
  end
end
