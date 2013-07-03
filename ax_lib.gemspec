$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "ax_lib/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "ax_lib"
  s.version     = AxLib::VERSION
  s.authors     = ['azimux']
  s.email       = ['azimux@gmail.com']
  s.homepage    = 'http://github.com/azimux/ax_lib'
  s.summary     = 'Shared crap'
  s.description = 'Shared crap'

  s.files = Dir["{app,lib}/**/*"] + ["MIT_LICENSE.txt"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.12"

  s.add_development_dependency "sqlite3"
end
