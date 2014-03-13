# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "iso_view/version"

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

  s.files             = %w( README.md CHANGELOG.md Gemfile MIT-LICENSE.txt )
  s.files            += Dir.glob("ru_area_city/**/*")
  s.files            += Dir.glob("lib/**/*")
  s.files            += Dir.glob("bin/**/*")
  s.executables       = [ "iso_view" ]
  s.require_paths = ["lib"]

  s.add_dependency "bundler", ">= 1.5.2"
  s.add_dependency "sinatra"
  s.add_dependency "json"
  s.add_dependency "country"
  s.add_dependency "vegas"
  s.add_dependency "rake"

end
