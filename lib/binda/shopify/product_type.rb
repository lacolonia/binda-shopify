require 'digest'

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
        Digest::MD5.hexdigest self.title
      end
    end
  end
end
