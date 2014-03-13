# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'iso_view/version'

Gem::Specification.new do |s|
  s.name        = 'iso_view'
  s.version     = IsoView::VERSION
  s.date        = '2014-03-13'
  s.summary     = "iso_view country"
  s.description = "Sinatra iso codes"
  s.authors     = ["Mike Bard"]
  s.email       = 'mibamur@gmail.com'
  s.homepage    = 'https://github.com/mibamur/iso_view'
  s.license = 'MIT'

  s.files         = `git ls-files -z`.split("\x0")
  s.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ["lib"]

  s.add_dependency "sinatra", "~> 1.4"
  s.add_dependency "sinatra-contrib", "~> 1.4"
  s.add_dependency "json", "~> 1.8"
  s.add_dependency "countries", "~> 0.9"
  s.add_dependency "vegas", "~> 0.1"

  s.add_development_dependency "bundler", "~> 1.5"
  s.add_development_dependency "rails", "~> 4.0"
  s.add_development_dependency "rake", "~> 10.1"
end

