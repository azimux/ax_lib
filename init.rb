require 'azimux'

require 'find'

Find.find(File.join(File.dirname(__FILE__), "lib", "azimux", "ext")) do |p|
  p = p.to_s
  require p if p =~ /\.rb$/ && p !~ /\.svn/
end