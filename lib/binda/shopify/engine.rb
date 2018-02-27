module Binda
  module Shopify
    class Engine < ::Rails::Engine
      isolate_namespace Binda::Shopify
    end
  end
end
