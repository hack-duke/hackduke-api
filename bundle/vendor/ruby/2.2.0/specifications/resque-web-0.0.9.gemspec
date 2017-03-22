# -*- encoding: utf-8 -*-
# stub: resque-web 0.0.9 ruby lib

Gem::Specification.new do |s|
  s.name = "resque-web"
  s.version = "0.0.9"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Tony Arcieri"]
  s.date = "2016-07-19"
  s.description = "A Rails-based frontend to the Resque job queue system."
  s.email = ["tony.arcieri@gmail.com"]
  s.homepage = "https://github.com/resque/resque-web"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.4.5.1"
  s.summary = "Rails-based Resque web interface"

  s.installed_by_version = "2.4.5.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<resque>, [">= 0"])
      s.add_runtime_dependency(%q<twitter-bootstrap-rails>, [">= 0"])
      s.add_runtime_dependency(%q<jquery-rails>, [">= 0"])
      s.add_runtime_dependency(%q<sass-rails>, [">= 0"])
      s.add_runtime_dependency(%q<coffee-rails>, [">= 0"])
    else
      s.add_dependency(%q<resque>, [">= 0"])
      s.add_dependency(%q<twitter-bootstrap-rails>, [">= 0"])
      s.add_dependency(%q<jquery-rails>, [">= 0"])
      s.add_dependency(%q<sass-rails>, [">= 0"])
      s.add_dependency(%q<coffee-rails>, [">= 0"])
    end
  else
    s.add_dependency(%q<resque>, [">= 0"])
    s.add_dependency(%q<twitter-bootstrap-rails>, [">= 0"])
    s.add_dependency(%q<jquery-rails>, [">= 0"])
    s.add_dependency(%q<sass-rails>, [">= 0"])
    s.add_dependency(%q<coffee-rails>, [">= 0"])
  end
end
