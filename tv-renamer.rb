require 'lib/tvdb/tvdb'
require 'lib/tvparser'
require 'lib/tvrenamer'

VALID_VIDEO_TYPES = %w{avi mkv m2v mpg mpeg mov ogm wmv mp4}

Renamer.new(ARGV.shift || ".").start