require 'ansi/code'

# Helper Utilities for File and Directory Management
class FileUtility

  # Create a directory
  def self.dir_creator(dir_path)
    Dir::mkdir(dir_path)
    puts "\t" + ANSI.green{"created"} + " #{dir_path}"
    return dir_path
  end

  #creates file, requires dir to exist
  def self.file_creator(dir_path, file_name, file_contents)
    file_dir = File.join(dir_path,file_name)
    file = open(file_dir, "w")
    file.write(file_contents)
    file.close
    puts "\t" + ANSI.green{"created"} + " #{file_dir}"
  end
end