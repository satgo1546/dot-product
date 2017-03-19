#!/usr/bin/env ruby
require 'optparse'
require 'fileutils'

class Main
	def initialize(argv = ARGV)
		@plugins = File.read("#{__dir__}/vim-plugin-list.txt").split("\n").reject { |s| s.strip.empty? }
		getopt(argv)
	end
	def getopt(argv)
		@options = {}
		OptionParser.new do |opts|
			opts.banner = "Usage: vim-plugin-update.rb [options]"
			opts.on("-i", "--install-only", "no update (i.e. install new plugins only)") do |v|
				@options[:noupdate] = true
			end
		end.parse!(argv)
	end
	def github_clone(repo)
		system *%w(git clone --verbose --depth=1 --single-branch), "https://github.com/#{repo}.git"
	end
	def vim_bundle_path
		if Gem.win_platform?
			"#{ENV["USERPROFILE"]}/_vimfiles/bundle"
		else
			"#{ENV["HOME"]}/.vim/bundle"
		end
	end
	def main
		puts "- noupdate == 1 -" if @options[:noupdate]
		FileUtils.mkdir_p vim_bundle_path
		Dir.chdir vim_bundle_path
		@plugins.each do |p|
			d = File.basename(p)
			puts "\e[34m#{p} (#{d})\e[0m"
			if FileTest.directory?(d)
				next if @options[:noupdate]
				if FileTest.directory?("#{d}/.git")
					system("cd #{d} && git pull")
				else
					puts "Warning: skipping non-git repository"
				end
			else
				github_clone p
			end
		end
	end
end

Main.new.main if __FILE__ == $0
