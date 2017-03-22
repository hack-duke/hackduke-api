# -*- encoding: utf-8 -*-
# stub: mandrill-api 1.0.53 ruby lib

Gem::Specification.new do |s|
  s.name = "mandrill-api"
  s.version = "1.0.53"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Mandrill Devs"]
  s.date = "2014-10-16"
  s.description = "A Ruby API library for the Mandrill email as a service platform."
  s.email = "community@mandrill.com"
  s.homepage = "https://bitbucket.org/mailchimp/mandrill-api-ruby/"
  s.rubygems_version = "2.4.5.1"
  s.summary = "A Ruby API library for the Mandrill email as a service platform."

  s.installed_by_version = "2.4.5.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<json>, ["< 2.0", ">= 1.7.7"])
      s.add_runtime_dependency(%q<excon>, ["< 1.0", ">= 0.16.0"])
    else
      s.add_dependency(%q<json>, ["< 2.0", ">= 1.7.7"])
      s.add_dependency(%q<excon>, ["< 1.0", ">= 0.16.0"])
    end
  else
    s.add_dependency(%q<json>, ["< 2.0", ">= 1.7.7"])
    s.add_dependency(%q<excon>, ["< 1.0", ">= 0.16.0"])
  end
end
