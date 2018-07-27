#!/usr/bin/env ruby
# ffmpeg-convert <from-extension> <to-extension>
param = []
case ARGV[1]
when "ogg"
	param = %w(-q 9)
when "flac"
	param = %w(-compression_level 12)
when "opus"
	param = %w(-compression_level 10)
end
Dir.glob("*.#{ARGV[0]}") do |filename|
	command = %w(ffmpeg -i)
	command << filename
	command.concat(param)
	command << "#{File.basename(filename, ".*")}.#{ARGV[1]}"
	system(*command)
end
