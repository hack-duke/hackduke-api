# -*- encoding: utf-8 -*-
# stub: slack 0 ruby lib

Gem::Specification.new do |s|
  s.name = "slack"
  s.version = "0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["elliottcable [http://ell.io/tt]"]
  s.date = "2013-02-28"
  s.homepage = "http://github.com/elliottcable/slack"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.4.5.1"
  s.summary = "An extension to Speck, providing convenience methods and monkey-patches."

  s.installed_by_version = "2.4.5.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<speck>, [">= 1"])
      s.add_development_dependency(%q<spark>, [">= 0"])
      s.add_development_dependency(%q<yard>, [">= 0.8.5.2"])
      s.add_development_dependency(%q<maruku>, [">= 0.6.1"])
    else
      s.add_dependency(%q<speck>, [">= 1"])
      s.add_dependency(%q<spark>, [">= 0"])
      s.add_dependency(%q<yard>, [">= 0.8.5.2"])
      s.add_dependency(%q<maruku>, [">= 0.6.1"])
    end
  else
    s.add_dependency(%q<speck>, [">= 1"])
    s.add_dependency(%q<spark>, [">= 0"])
    s.add_dependency(%q<yard>, [">= 0.8.5.2"])
    s.add_dependency(%q<maruku>, [">= 0.6.1"])
  end
end
