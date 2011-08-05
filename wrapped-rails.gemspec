# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "wrapped-rails/version"

Gem::Specification.new do |s|
  s.name        = "wrapped-rails"
  s.version     = Wrapped::Rails::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["TODO: Write your name"]
  s.email       = ["TODO: Write your email address"]
  s.homepage    = ""
  s.summary     = %q{TODO: Write a gem summary}
  s.description = %q{TODO: Write a gem description}

  s.rubyforge_project = "wrapped-rails"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency('wrapped')

  s.add_development_dependency('rspec')
  s.add_development_dependency('cucumber')
  s.add_development_dependency('diesel')
  s.add_development_dependency('aruba')
  s.add_development_dependency('rails')
end
