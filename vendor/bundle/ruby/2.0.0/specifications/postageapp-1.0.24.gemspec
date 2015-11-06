# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "postageapp"
  s.version = "1.0.24"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Oleg Khabarov", "Scott Tadman", "The Working Group Inc."]
  s.date = "2014-12-10"
  s.description = "Gem that interfaces with PostageApp.com service to send emails from web apps"
  s.email = ["oleg@khabarov.ca", "scott@twg.ca"]
  s.homepage = "http://github.com/postageapp/postageapp-ruby"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "2.0.14"
  s.summary = "Easier way to send email from web apps"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<json>, [">= 0"])
    else
      s.add_dependency(%q<json>, [">= 0"])
    end
  else
    s.add_dependency(%q<json>, [">= 0"])
  end
end
