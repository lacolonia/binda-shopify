$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "binda/shopify/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "binda-shopify"
  s.version     = Binda::Shopify::VERSION
  s.authors     = ["Marco Crepaldi"]
  s.email       = ["marco.crepaldi@gmail.com"]
  s.homepage    = "lacolonia.studio"
  s.summary     = "Binda plugin that lets you import products from your Shopify store."
  s.description = ""
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.1.5"
  s.add_dependency "binda", "~> 0.1"
  s.add_dependency 'shopify_api'
  s.add_dependency 'pg'
  s.add_dependency 'deface'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'byebug'
  s.add_development_dependency 'shopify-mock'
  s.add_development_dependency 'database_cleaner'
end
