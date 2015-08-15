$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "rok_base/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "rok_base"
  s.version     = RokBase::VERSION
  s.authors     = ["Sean Earle"]
  s.email       = ["sean.r.earle@gmail.com"]
  s.homepage    = "http://www.oequacki.com/"
  s.summary     = "Base package for Rok gems"
  s.description = "This package is for shared code between rok_cms and rok_blog. You probably don't want to install this manually."
  s.license     = "Beerware"

  s.files = Dir["{app,config,db,lib}/**/*", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.3"
  s.add_development_dependency "pg"

  # Abilities
  s.add_dependency "cancancan"

  s.add_dependency 'simple_form'

  # Pagination
  s.add_dependency 'kaminari'

  # Templating
  s.add_dependency 'liquid'

  # Images
  s.add_dependency 'carrierwave'
  s.add_dependency 'rmagick'

  # Pure-admin dependencies
  s.add_dependency 'font-awesome-rails'
  s.add_dependency 'pure-css-rails'
end
