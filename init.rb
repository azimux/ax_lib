require 'azimux/azimux'

require 'find'

Find.find(File.join(File.dirname(__FILE__), "lib", "azimux", "ext")) do |p|
  puts p
  require p if p =~ /\.rb$/ && p !~ /\.svn/
end