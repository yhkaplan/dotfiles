#!/usr/bin/env ruby
require 'optparse'

args = {}
OptionParser.new do |opt|
  opt.on('--path FILE_PATH') { |o| args[:path] = o }
end.parse!

file_path = args[:path]

File.open(file_path, 'r+') do |file|
  contents = File.read(file)
  without_multiline_contents = contents.gsub(/\/\*\*.*\/$/m, "")
  without_single_line_contents = without_multiline_contents.gsub(/\/\/.*/, "")
  file.write(without_single_line_contents)
end
