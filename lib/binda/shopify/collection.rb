module Binda
  module Shopify
    class Collection < Item
      def sorted_products
        item.products.map(&:id).join(",")
      end
    end
  end
end
