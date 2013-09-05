# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "pagelime_rails"
  s.version = "0.1.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Emil Anticevic", "Joel Van Horn"]
  s.date = "2013-09-05"
  s.description = ""
  s.email = "eanticev@gmail.com"
  s.files = [
    "Gemfile",
    "Heroku.md",
    "MIT-LICENSE",
    "Rakefile",
    "Readme.md",
    "VERSION",
    "app/controllers/pagelime_receiver_controller.rb",
    "app/helpers/pagelime_helper.rb",
    "config/routes.rb",
    "init.rb",
    "install.rb",
    "lib/pagelime.rb",
    "lib/pagelime/rails.rb",
    "lib/pagelime/rails/controller_extensions.rb",
    "lib/pagelime/rails/engine.rb",
    "lib/pagelime/rails/initializer.rb",
    "lib/pagelime/rails/routing_extensions.rb",
    "lib/pagelime/s3_rails_cache.rb",
    "lib/tasks/pagelime.rake",
    "pagelime_rails.gemspec",
    "rails/init.rb",
    "test/pagelime_test.rb",
    "test/test_helper.rb",
    "uninstall.rb"
  ]
  s.homepage = "http://github.com/eanticev/pagelime_rails"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "2.0.7"
  s.summary = "Pagelime Rails Plugin"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<nokogiri>, [">= 0"])
      s.add_runtime_dependency(%q<pagelime-rack>, [">= 0"])
      s.add_development_dependency(%q<bundler>, [">= 1.0.0"])
      s.add_development_dependency(%q<jeweler>, [">= 1.6.4"])
    else
      s.add_dependency(%q<nokogiri>, [">= 0"])
      s.add_dependency(%q<pagelime-rack>, [">= 0"])
      s.add_dependency(%q<bundler>, [">= 1.0.0"])
      s.add_dependency(%q<jeweler>, [">= 1.6.4"])
    end
  else
    s.add_dependency(%q<nokogiri>, [">= 0"])
    s.add_dependency(%q<pagelime-rack>, [">= 0"])
    s.add_dependency(%q<bundler>, [">= 1.0.0"])
    s.add_dependency(%q<jeweler>, [">= 1.6.4"])
  end
end

