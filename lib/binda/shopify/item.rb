module Binda
  module Shopify
    class Item
      attr_accessor :item, :shop

      def initialize item, shop
        @item = item
        @shop = shop
      end

      def id
        item.id
      end

      def edit_url
        "https://#{shop.domain}/admin/#{item.model_name.element.pluralize}/#{item.id}"
      end

      def method_missing name, params = nil, &block
        if item.respond_to? name
          item.send(name, params)
        else
          super
        end
      end
    end
  end
end
