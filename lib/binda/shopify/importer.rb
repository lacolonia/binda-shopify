require 'shopify_api'

module Binda
  module Shopify
    class Importer
      attr_accessor :client, :settings

      def initialize
        settings_slug = 'shopify-settings'
        @settings = ::Binda::Structure.find_by(slug: 'shopify-settings').board
        api_key, password, shared_secret, shop_name = ::Binda::Shopify::CONNECTION_KEYS.map{|field| settings.get_string("#{settings_slug}-#{field.to_s.gsub('_', '-')}").strip }

        @client = ::ShopifyAPI
        @client::Base.site = "https://#{api_key}:#{password}@#{shop_name}.myshopify.com/admin"
        @client::Session.setup(api_key: api_key, secret: shared_secret)
      end

      def run!
        start_time = Time.now
        ::Binda::Shopify::STRUCTURES.each do |name, structure_fields|
          structure_slug = settings.get_string("#{@settings.slug}-#{name.to_s.gsub('_', '-')}").strip.parameterize
          structure = ::Binda::Structure.find_by slug: structure_slug
          send("fetch_#{name.to_s.pluralize}").each do |item|
            if item.id.present?
              component = ::Binda::Component.find_or_initialize_by slug: item.id, structure: structure
              component.name = item.title
              component.publish_state = 'published'
              component.updated_at = Time.now
              component.save
              structure_fields.each do |field_group_slug, fields|
                field_group_slug = "#{structure_slug}-#{field_group_slug}"
                field_group = structure.field_groups.find_by slug: field_group_slug
                if field_group
                  fields.each do |field_slug, method|
                    field_setting = field_group.field_settings.find_by(slug: "#{field_group_slug}-#{field_slug}")
                    component.strings.find_by(field_setting_id: field_setting.id).update content: item.send(method) if field_setting
                  end
                end
              end
            end
          end
          structure.components.where("updated_at < ?", start_time).update_all publish_state: 'draft'
        end

        ::Binda::Shopify::STRUCTURES.keys
      end

      def fetch_collections
        @client::CustomCollection.find(:all, params: { limit: 250 }).map{|p| ::Binda::Shopify::Collection.new(p, shop)}
      end

      def fetch_products
        @client::Product.find(:all, params: { limit: 250 }).map{|p| ::Binda::Shopify::Product.new(p, shop)}
      end

      def fetch_product_types
        product_types = @client::Product.find(:all, params: { limit: 250 }).map(&:product_type).uniq
        product_types.map{|p| ::Binda::Shopify::ProductType.new(p, shop) }
      end

      def shop
        @shop ||= @client::Shop.current
      end
    end
  end
end
