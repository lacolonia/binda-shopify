# Main classes
require 'binda'
require "binda/shopify/engine"

# Secondary classes
require 'binda/shopify/collection'
require 'binda/shopify/importer'
require 'binda/shopify/installer'
require 'binda/shopify/item'
require 'binda/shopify/product'
require 'binda/shopify/product_type'

# Vendor
require 'deface'

module Binda
  module Shopify
    CONNECTION_KEYS = %i(api_key password shared_secret shop_name)
    STRUCTURES = {
      product: {
        'shopify-details' => {
          'handle' => 'handle',
          'edit-product-url' => 'edit_url',
          'inventory-item-id' => 'inventory_item_id'
        }
      },
      collection: {
        'shopify-details' => {
          'edit-collection-url' => 'edit_url',
          'handle' => 'handle',
          'sorted-products:text' => 'sorted_products'
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
