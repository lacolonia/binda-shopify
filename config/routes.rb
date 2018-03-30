Binda::Engine.routes.draw do
  namespace :shopify do
    get '/import' => 'imports#import', as: 'import'
  end
end
