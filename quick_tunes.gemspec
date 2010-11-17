# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "quick_tunes/version"

Gem::Specification.new do |s|
  s.name        = "quick_tunes"
  s.version     = QuickTunes::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Rodrigo Tassinari de Oliveira"]
  s.email       = ["rodrigo@pittlandia.net"]
  s.homepage    = ""
  s.summary     = %q{Given a band name, display YouTube links to the 5 most popular songs according to Last.fm}
  s.description = %q{Given a band name, display YouTube links to the 5 most popular songs according to Last.fm.}

  s.rubyforge_project = "quick_tunes"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
  s.add_development_dependency "rspec", "~> 2.1.0"
  
  #s.add_dependency "", ""
  s.add_dependency "crack", "0.1.8"
  
end
