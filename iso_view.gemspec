# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'iso_view/version'

Gem::Specification.new do |s|
  s.name        = 'iso_view'
  s.version     = IsoView::VERSION
  s.date        = '2014-03-13'
  s.summary     = "Sinatra iso codes"
  s.description = "Sinatra iso codes"
  s.authors     = ["Mike Bard"]
  s.email       = 'mibamur@gmail.com'
  s.homepage    = 'https://github.com/mibamur/iso_view'
  s.license = 'MIT'

  s.files         = `git ls-files -z`.split("\x0")
  s.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ["lib"]

  s.add_dependency "sinatra"
  s.add_dependency "json"
  s.add_dependency "country"
  s.add_dependency "vegas"

  s.add_development_dependency "bundler", "~> 1.5"
  s.add_development_dependency "rake"
end

