module Binda
  module Shopify
    class ImportsController < ApplicationController
      def import
        importer = Binda::Shopify::Importer.new
      end
    end
  end
end
