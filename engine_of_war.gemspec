# -*- encoding: utf-8 -*-
require File.expand_path('../lib/engine_of_war/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Thunderbolt Labs"]
  gem.email         = ["us@thunderboltlabs.com"]
  gem.description   = "Semi-static site engine."
  gem.summary       = "Semi-static site endine based on Padrino"
  gem.homepage      = "http://thunderboltlabs.com"

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "engine_of_war"
  gem.require_paths = ["lib"]
  gem.version       = EngineOfWar::VERSION

  gem.add_dependency 'sinatra', ">= 1.3"
  gem.add_dependency "compass"
  gem.add_dependency "padrino"
  gem.add_dependency "active_support"
  gem.add_dependency "builder"
  gem.add_dependency 'haml'
  gem.add_dependency 'sass', ">= 3.1.7"
  gem.add_dependency "RedCloth"
  gem.add_dependency "rdiscount"
  gem.add_dependency "coffee-script"
  gem.add_dependency "rack-google-analytics"
  gem.add_dependency "rack-gauges"
  gem.add_dependency 'rpm_contrib'
  gem.add_dependency 'newrelic_rpm'

  gem.add_development_dependency "yard"
  gem.add_development_dependency "rake"
  gem.add_development_dependency "rspec"
  gem.add_development_dependency "capybara"
  gem.add_development_dependency "fakeweb"
  gem.add_development_dependency 'guard-rspec'
  gem.add_development_dependency "guard-bundler"
  gem.add_development_dependency 'ruby_gntp'
end
