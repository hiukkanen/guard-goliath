# encoding: utf-8

require File.expand_path('../lib/guard/goliath/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Nikolay Norkin"]

  gem.email         = ["zduderman@gmail.com"]
  gem.description   = "Automatically reloads your Goliath app on file change using Guard."
  gem.homepage      = "https://github.com/duderman/guard-goliath"
  gem.summary       = gem.description
  gem.license       = 'MIT'

  gem.name          = "guard-goliath"
  gem.require_paths = ["lib"]
  gem.files         = `git ls-files`.split("\n")
  gem.version       = Guard::GoliathVersion::VERSION

  gem.add_dependency "guard"
  gem.add_dependency "ffi"
  gem.add_dependency "spoon"
  gem.add_dependency "rb-inotify"
  gem.add_dependency "libnotify"

  gem.add_development_dependency "rake"
  gem.add_development_dependency "bundler"
  gem.add_development_dependency "rack"
end
