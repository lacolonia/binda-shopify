module Binda
  module Shopify
    class Product
      attr_accessor :product, :shop
      def initialize product, shop
        @product = product
        @shop = shop
      end

      def id
        product.id
      end

      def edit_url
        "https://#{shop.domain}/admin/products/#{product.id}"
      end

      def method_missing name, params = nil, &block
        if product.respond_to? name
          product.send(name, params)
        else
          super
        end
      end
    end
  end
end
