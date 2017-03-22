# -*- encoding: utf-8 -*-
# stub: resque-scheduler 4.3.0 ruby lib

Gem::Specification.new do |s|
  s.name = "resque-scheduler"
  s.version = "4.3.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Ben VandenBos", "Simon Eskildsen", "Ryan Biesemeyer", "Dan Buch"]
  s.bindir = "exe"
  s.date = "2016-06-26"
  s.description = "    Light weight job scheduling on top of Resque.\n    Adds methods enqueue_at/enqueue_in to schedule jobs in the future.\n    Also supports queueing jobs on a fixed, cron-like schedule.\n"
  s.email = ["bvandenbos@gmail.com", "sirup@sirupsen.com", "ryan@yaauie.com", "dan@meatballhat.com"]
  s.executables = ["resque-scheduler"]
  s.files = ["exe/resque-scheduler"]
  s.homepage = "http://github.com/resque/resque-scheduler"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.4.5.1"
  s.summary = "Light weight job scheduling on top of Resque"

  s.installed_by_version = "2.4.5.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bundler>, [">= 0"])
      s.add_development_dependency(%q<json>, [">= 0"])
      s.add_development_dependency(%q<kramdown>, [">= 0"])
      s.add_development_dependency(%q<minitest>, [">= 0"])
      s.add_development_dependency(%q<mocha>, [">= 0"])
      s.add_development_dependency(%q<pry>, [">= 0"])
      s.add_development_dependency(%q<rack-test>, [">= 0"])
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<simplecov>, [">= 0"])
      s.add_development_dependency(%q<test-unit>, [">= 0"])
      s.add_development_dependency(%q<yard>, [">= 0"])
      s.add_development_dependency(%q<rubocop>, ["~> 0.40.0"])
      s.add_runtime_dependency(%q<mono_logger>, ["~> 1.0"])
      s.add_runtime_dependency(%q<redis>, ["~> 3.3"])
      s.add_runtime_dependency(%q<resque>, ["~> 1.26"])
      s.add_runtime_dependency(%q<rufus-scheduler>, ["~> 3.2"])
    else
      s.add_dependency(%q<bundler>, [">= 0"])
      s.add_dependency(%q<json>, [">= 0"])
      s.add_dependency(%q<kramdown>, [">= 0"])
      s.add_dependency(%q<minitest>, [">= 0"])
      s.add_dependency(%q<mocha>, [">= 0"])
      s.add_dependency(%q<pry>, [">= 0"])
      s.add_dependency(%q<rack-test>, [">= 0"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<simplecov>, [">= 0"])
      s.add_dependency(%q<test-unit>, [">= 0"])
      s.add_dependency(%q<yard>, [">= 0"])
      s.add_dependency(%q<rubocop>, ["~> 0.40.0"])
      s.add_dependency(%q<mono_logger>, ["~> 1.0"])
      s.add_dependency(%q<redis>, ["~> 3.3"])
      s.add_dependency(%q<resque>, ["~> 1.26"])
      s.add_dependency(%q<rufus-scheduler>, ["~> 3.2"])
    end
  else
    s.add_dependency(%q<bundler>, [">= 0"])
    s.add_dependency(%q<json>, [">= 0"])
    s.add_dependency(%q<kramdown>, [">= 0"])
    s.add_dependency(%q<minitest>, [">= 0"])
    s.add_dependency(%q<mocha>, [">= 0"])
    s.add_dependency(%q<pry>, [">= 0"])
    s.add_dependency(%q<rack-test>, [">= 0"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<simplecov>, [">= 0"])
    s.add_dependency(%q<test-unit>, [">= 0"])
    s.add_dependency(%q<yard>, [">= 0"])
    s.add_dependency(%q<rubocop>, ["~> 0.40.0"])
    s.add_dependency(%q<mono_logger>, ["~> 1.0"])
    s.add_dependency(%q<redis>, ["~> 3.3"])
    s.add_dependency(%q<resque>, ["~> 1.26"])
    s.add_dependency(%q<rufus-scheduler>, ["~> 3.2"])
  end
end
