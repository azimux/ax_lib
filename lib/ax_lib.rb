module AxLib
  class Engine < Rails::Engine
    config.autoload_paths << File.expand_path("..", __FILE__)

    initializer "ax_lib" do
      require 'azimux'

      require 'find'

      required = false
      Find.find(File.join(File.dirname(__FILE__), "azimux", "ext")) do |p|
        p = p.to_s
        required = true
        require p if p =~ /\.rb$/ && p !~ /\.svn/
      end
      raise 'wtf, nothing required' unless required
    end
  end
end