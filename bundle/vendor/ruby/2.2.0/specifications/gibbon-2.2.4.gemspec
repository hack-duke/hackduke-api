# -*- encoding: utf-8 -*-
# stub: gibbon 2.2.4 ruby lib

Gem::Specification.new do |s|
  s.name = "gibbon"
  s.version = "2.2.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Amro Mousa"]
  s.date = "2016-05-22"
  s.description = "A wrapper for MailChimp API 3.0"
  s.email = ["amromousa@gmail.com"]
  s.homepage = "http://github.com/amro/gibbon"
  s.licenses = ["MIT"]
  s.post_install_message = "IMPORTANT: Gibbon now targets MailChimp API 3.0, which is very different from API 2.0. Use Gibbon 1.x if you need to target API 2.0."
  s.required_ruby_version = Gem::Requirement.new(">= 2.0.0")
  s.rubyforge_project = "gibbon"
  s.rubygems_version = "2.4.5.1"
  s.summary = "A wrapper for MailChimp API 3.0"

  s.installed_by_version = "2.4.5.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<faraday>, [">= 0.9.1"])
      s.add_runtime_dependency(%q<multi_json>, [">= 1.11.0"])
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<rspec>, ["= 3.2.0"])
      s.add_development_dependency(%q<webmock>, ["~> 1.21.0"])
    else
      s.add_dependency(%q<faraday>, [">= 0.9.1"])
      s.add_dependency(%q<multi_json>, [">= 1.11.0"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<rspec>, ["= 3.2.0"])
      s.add_dependency(%q<webmock>, ["~> 1.21.0"])
    end
  else
    s.add_dependency(%q<faraday>, [">= 0.9.1"])
    s.add_dependency(%q<multi_json>, [">= 1.11.0"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<rspec>, ["= 3.2.0"])
    s.add_dependency(%q<webmock>, ["~> 1.21.0"])
  end
end
