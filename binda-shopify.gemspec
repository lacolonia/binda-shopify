$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "binda/shopify/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "binda-shopify"
  s.version     = Binda::Shopify::VERSION
  s.authors     = ["Marco Crepaldi"]
  s.email       = ["marco.crepaldi@gmail.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of Binda::Shopify."
  s.description = "TODO: Description of Binda::Shopify."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.1.5"

  s.add_development_dependency "sqlite3"
end
