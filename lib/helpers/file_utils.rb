require 'ansi/code'

# Helper Utilities for File and Directory Management
class FileUtility
  attr_accessor :logger

  # Create a directory
  def self.dir_creator(dir_path)
    @logger = LOG || OrbLogger::OrbLogger.new
    @logger.progname = self.class.name
    Dir.mkdir(dir_path) unless File.exist?(dir_path)
    @logger.info "#{ANSI.green { 'created' }} #{dir_path}"
    dir_path
  end

  # creates file, requires dir to exist
  def self.file_creator(dir_path, file_name, file_contents)
    file_dir = File.join(dir_path, file_name)
    File.open(file_dir, 'w') { |file| file.write(file_contents) }
    @logger.info "#{ANSI.green { 'created' }} #{file_dir}"
  end
end
