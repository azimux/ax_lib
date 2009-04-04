require 'azimux/azimux'

require 'find'

Find.find(File.join(File.dirname(__FILE__), "azimux", "ext")) do |p|
  require p if p =~ /.rb$/
end