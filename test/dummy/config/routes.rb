Rails.application.routes.draw do
  mount Binda::Shopify::Engine => "/binda-shopify"
end
