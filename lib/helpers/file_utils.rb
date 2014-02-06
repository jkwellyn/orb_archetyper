require 'ansi/code'

#Helper Utilities for File and Directory Management
class FileUtils

	#modify to suppport v1.9.2.3.  as this uses 2.0 functionality
	def FileUtils.dir_creator(new_dir_flag, dir_path)  
	  if new_dir_flag
	    if Dir.exists?(dir_path)
	      raise "Error. Directory already exists: #{dir_path}"
	    end
	  end

	  Dir::mkdir(dir_path)
	  puts "\t" + ANSI.green{"created"} + " #{dir_path}"

	  return dir_path
	end

	#creates file, requires dir to exist
	def self.file_creator(dir_path, file_name, file_contents)
	  
	  file_dir = dir_path + "/" + file_name

	  file = open(file_dir, "w")
	  file.write(file_contents)
	  file.close

	  puts "\t" + ANSI.green{"created"} + " #{file_dir}"
	end

end
