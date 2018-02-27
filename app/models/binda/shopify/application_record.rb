module Binda
  module Shopify
    class ApplicationRecord < ActiveRecord::Base
      self.abstract_class = true
    end
  end
end
