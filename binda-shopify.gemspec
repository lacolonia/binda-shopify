$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "binda/shopify/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "binda-shopify"
  s.version     = Binda::Shopify::VERSION
  s.authors     = ["Marco Crepaldi"]
  s.email       = ["marco.crepaldi@gmail.com"]
  s.homepage    = "http://lacolonia.studio"
  s.summary     = "Binda plugin that lets you import products from your Shopify store."
  s.description = ""
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails",                          "~> 5.1.5"
  s.add_dependency "binda",                          "~> 0.1.9"
  s.add_dependency "shopify_api",                    "~> 4.3.0"
  s.add_dependency "deface",                         "~> 1.3.0"

  s.add_development_dependency "pg",                 "~> 1.0"
  s.add_development_dependency 'rspec-rails',        ">= 3.5",  "< 3.8"
  s.add_development_dependency 'byebug',             "~> 10.0"
  s.add_development_dependency "factory_bot_rails",  "~> 4.8"
  s.add_development_dependency 'database_cleaner',   ">= 1.6",  "< 2"
  s.add_development_dependency "shopify-mock",       "~> 0.1.2"
end
