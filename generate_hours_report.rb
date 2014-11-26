require './requirements'

# Gets newest file in directory
newest_file_path = Dir.glob(File.join('./tasks', '*.*')).max { |a,b| File.ctime(a) <=> File.ctime(b) }
HoursConverter.perform newest_file_path
