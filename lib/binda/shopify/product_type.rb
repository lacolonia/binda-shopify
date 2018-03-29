module Binda
  module Shopify
    class ProductType
      attr_accessor :name
      def initialize name, shop
        @name = name
      end

      def title
        name
      end

      def id
        SecureRandom.hex(6)
      end
    end
  end
end
