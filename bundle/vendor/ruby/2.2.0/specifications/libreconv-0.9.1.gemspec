# -*- encoding: utf-8 -*-
# stub: libreconv 0.9.1 ruby lib

Gem::Specification.new do |s|
  s.name = "libreconv"
  s.version = "0.9.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Richard Nystr\u{f6}m"]
  s.date = "2015-07-01"
  s.description = " Convert office documents to PDF using LibreOffice. "
  s.email = ["ricny046@gmail.com"]
  s.homepage = "https://github.com/ricn/libreconv"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.4.5.1"
  s.summary = "Convert office documents to PDF."

  s.installed_by_version = "2.4.5.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<spoon>, [">= 0"])
      s.add_development_dependency(%q<bundler>, [">= 0"])
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<rspec>, ["~> 3.2.0"])
    else
      s.add_dependency(%q<spoon>, [">= 0"])
      s.add_dependency(%q<bundler>, [">= 0"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<rspec>, ["~> 3.2.0"])
    end
  else
    s.add_dependency(%q<spoon>, [">= 0"])
    s.add_dependency(%q<bundler>, [">= 0"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<rspec>, ["~> 3.2.0"])
  end
end
