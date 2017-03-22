# -*- encoding: utf-8 -*-
# stub: combine_pdf 0.2.31 ruby lib

Gem::Specification.new do |s|
  s.name = "combine_pdf"
  s.version = "0.2.31"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Boaz Segev"]
  s.date = "2016-08-22"
  s.description = "A nifty gem, in pure Ruby, to parse PDF files and combine (merge) them with other PDF files, number the pages, watermark them or stamp them, create tables, add basic text objects etc` (all using the PDF file format)."
  s.email = ["boaz@2be.co.il"]
  s.homepage = "https://github.com/boazsegev/combine_pdf"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.4.5.1"
  s.summary = "Combine, stamp and watermark PDF files in pure Ruby."

  s.installed_by_version = "2.4.5.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<ruby-rc4>, [">= 0.1.5"])
      s.add_development_dependency(%q<bundler>, ["~> 1.7"])
      s.add_development_dependency(%q<rake>, ["~> 10.0"])
    else
      s.add_dependency(%q<ruby-rc4>, [">= 0.1.5"])
      s.add_dependency(%q<bundler>, ["~> 1.7"])
      s.add_dependency(%q<rake>, ["~> 10.0"])
    end
  else
    s.add_dependency(%q<ruby-rc4>, [">= 0.1.5"])
    s.add_dependency(%q<bundler>, ["~> 1.7"])
    s.add_dependency(%q<rake>, ["~> 10.0"])
  end
end
