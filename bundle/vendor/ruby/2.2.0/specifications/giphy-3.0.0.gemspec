# -*- encoding: utf-8 -*-
# stub: giphy 3.0.0 ruby lib

Gem::Specification.new do |s|
  s.name = "giphy"
  s.version = "3.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Sebastian Sogamoso"]
  s.date = "2015-08-27"
  s.description = "A Ruby interface to the Giphy API."
  s.email = ["sebasoga@gmail.com"]
  s.executables = ["giphy"]
  s.files = ["bin/giphy"]
  s.homepage = "http://github.com/sebasoga/giphy"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.4.5.1"
  s.summary = "Enjoy Giphy API from you Ruby programs and command line"

  s.installed_by_version = "2.4.5.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bundler>, ["~> 1.3"])
      s.add_development_dependency(%q<rake>, ["~> 10.1"])
      s.add_development_dependency(%q<rspec>, ["~> 2.14"])
      s.add_development_dependency(%q<rspec-its>, ["~> 1.0"])
      s.add_runtime_dependency(%q<faraday>, ["~> 0.9"])
      s.add_runtime_dependency(%q<faraday_middleware>, ["~> 0.9"])
      s.add_runtime_dependency(%q<faraday_middleware-parse_oj>, ["~> 0.3"])
      s.add_runtime_dependency(%q<launchy>, ["~> 2.4"])
    else
      s.add_dependency(%q<bundler>, ["~> 1.3"])
      s.add_dependency(%q<rake>, ["~> 10.1"])
      s.add_dependency(%q<rspec>, ["~> 2.14"])
      s.add_dependency(%q<rspec-its>, ["~> 1.0"])
      s.add_dependency(%q<faraday>, ["~> 0.9"])
      s.add_dependency(%q<faraday_middleware>, ["~> 0.9"])
      s.add_dependency(%q<faraday_middleware-parse_oj>, ["~> 0.3"])
      s.add_dependency(%q<launchy>, ["~> 2.4"])
    end
  else
    s.add_dependency(%q<bundler>, ["~> 1.3"])
    s.add_dependency(%q<rake>, ["~> 10.1"])
    s.add_dependency(%q<rspec>, ["~> 2.14"])
    s.add_dependency(%q<rspec-its>, ["~> 1.0"])
    s.add_dependency(%q<faraday>, ["~> 0.9"])
    s.add_dependency(%q<faraday_middleware>, ["~> 0.9"])
    s.add_dependency(%q<faraday_middleware-parse_oj>, ["~> 0.3"])
    s.add_dependency(%q<launchy>, ["~> 2.4"])
  end
end
