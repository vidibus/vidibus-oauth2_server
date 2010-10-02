# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{vidibus-oauth2_server}
  s.version = "0.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Andre Pankratz"]
  s.date = %q{2010-10-02}
  s.description = %q{OAuth2 server for Rails 3 with Mongoid.}
  s.email = %q{andre@vidibus.com}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    ".document",
     ".gitignore",
     "Gemfile",
     "Gemfile.lock",
     "LICENSE",
     "README.rdoc",
     "Rakefile",
     "VERSION",
     "app/controllers/oauth2_controller.rb",
     "app/models/oauth2_token.rb",
     "config/locales/en.yml",
     "config/routes.rb",
     "lib/vidibus-oauth2_server.rb",
     "lib/vidibus/oauth2_server.rb",
     "lib/vidibus/oauth2_server/extensions.rb",
     "lib/vidibus/oauth2_server/extensions/controller.rb"
  ]
  s.homepage = %q{http://github.com/vidibus/vidibus-oauth2_server}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{OAuth2 server for Rails 3 with Mongoid.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rails>, ["~> 3.0.0"])
      s.add_runtime_dependency(%q<mongoid>, ["~> 2.0.0.beta.20"])
      s.add_runtime_dependency(%q<vidibus-core_extensions>, [">= 0"])
      s.add_runtime_dependency(%q<vidibus-uuid>, [">= 0"])
    else
      s.add_dependency(%q<rails>, ["~> 3.0.0"])
      s.add_dependency(%q<mongoid>, ["~> 2.0.0.beta.20"])
      s.add_dependency(%q<vidibus-core_extensions>, [">= 0"])
      s.add_dependency(%q<vidibus-uuid>, [">= 0"])
    end
  else
    s.add_dependency(%q<rails>, ["~> 3.0.0"])
    s.add_dependency(%q<mongoid>, ["~> 2.0.0.beta.20"])
    s.add_dependency(%q<vidibus-core_extensions>, [">= 0"])
    s.add_dependency(%q<vidibus-uuid>, [">= 0"])
  end
end

