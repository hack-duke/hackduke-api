# -*- encoding: utf-8 -*-
# stub: faraday_middleware-parse_oj 0.3.0 ruby lib

Gem::Specification.new do |s|
  s.name = "faraday_middleware-parse_oj"
  s.version = "0.3.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Vsevolod Romashov"]
  s.date = "2014-04-24"
  s.description = "Faraday middleware for parsing JSON using the Oj parser."
  s.email = ["7@7vn.ru"]
  s.homepage = "https://github.com/7even/faraday_middleware-parse_oj"
  s.rubygems_version = "2.4.5.1"
  s.summary = "Oj middleware for Faraday"

  s.installed_by_version = "2.4.5.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<faraday>, ["~> 0.9.0"])
      s.add_runtime_dependency(%q<faraday_middleware>, ["~> 0.9.1"])
      s.add_runtime_dependency(%q<oj>, ["~> 2.0"])
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<rspec>, [">= 0"])
    else
      s.add_dependency(%q<faraday>, ["~> 0.9.0"])
      s.add_dependency(%q<faraday_middleware>, ["~> 0.9.1"])
      s.add_dependency(%q<oj>, ["~> 2.0"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<rspec>, [">= 0"])
    end
  else
    s.add_dependency(%q<faraday>, ["~> 0.9.0"])
    s.add_dependency(%q<faraday_middleware>, ["~> 0.9.1"])
    s.add_dependency(%q<oj>, ["~> 2.0"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<rspec>, [">= 0"])
  end
end
