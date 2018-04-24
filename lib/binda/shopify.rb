require 'binda'
require "binda/shopify/engine"
require 'binda/shopify/importer'
require 'binda/shopify/item'
require 'binda/shopify/product'
require 'binda/shopify/collection'
require 'binda/shopify/product_type'
require 'deface'

module Binda
  module Shopify
    CONNECTION_KEYS = %i(api_key password shared_secret shop_name)
    STRUCTURES = {
      product: {
        'shopify-details' => {
          'handle' => 'handle',
          'edit-product-url' => 'edit_url',
          'inventory-item-id' => ['variants', 'first', 'inventory_item_id']
        }
      },
      collection: {
        'shopify-details' => {
          'edit-collection-url' => 'edit_url',
          'handle' => 'handle'
        }
      },
      product_type: {
        'shopify-details' => {
          'handle' => 'name'
        }
      }
    }
  end
end
