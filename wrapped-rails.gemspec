# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "wrapped-rails/version"

Gem::Specification.new do |s|
  s.name        = "wrapped-rails"
  s.version     = Wrapped::Rails::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Mike Burns"]
  s.email       = ["mburns@thoughtbot.com"]
  s.homepage    = "http://github.com/mike-burns/wrapped-rails"
  s.summary     = %q{Auto-wrap optional data values in your Rails app for your protection.}
  s.description = %q{
    Databases are a wild West of NULL values. Sure, you put some NOT NULL
    constraints here and there but, in general? Mostly NULL. That turns into
    nil, which turns into NoMethodError, which turns into a Cucumber scenario,
    which turns into #try, and in general it's exhausting.

    Catch this all before the push to production by using wrapped-rails.

    This gem inspects your models for presence-checking validations. For each that
    it does _not_ find it wraps the value. You must then unwrap the value.

    Why the extra work? Because you want to do it now, not later.

        <%= @user.middle_name.unwrap_or('Q') { |mn| mn.first } %>

    Is this more code than #try or #|| ? Hardly, but you're asking the wrong
    question here. This is more careful code. This is code where testing the
    "happy path" is good enough 80% of the time. This is code that lets you
    spend more time writing code and less time tracking errors.

    This is what people mean when they talk about caring about your work.
  }

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
  s.add_development_dependency('sqlite3')
end
