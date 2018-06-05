require 'shopify_api'

module Binda
  module Shopify
    # Shopify Importer
    #
    # This class is responsible for fetching data from a Shopify account
    class Importer
      attr_accessor :client, :settings

      def initialize
        settings_slug = 'shopify-settings'
        @settings = ::Binda::Structure.find_by(slug: 'shopify-settings').board
        connection_keys = ::Binda::Shopify::CONNECTION_KEYS.map do |field|
          slug = "#{settings_slug}-#{field.to_s.tr('_', '-')}"
          settings.get_string(slug).strip
        end
        api_key, password, shared_secret, shop_name = connection_keys

        @client = ::ShopifyAPI
        @client::Base.site = "https://#{api_key}:#{password}@#{shop_name}.myshopify.com/admin"
        @client::Session.setup(api_key: api_key, secret: shared_secret)
      end

      def run!
        start_time = Time.now
        ::Binda::Shopify::STRUCTURES.each do |name, structure_fields|
          slug = "#{@settings.slug}-#{name.to_s.tr('_', '-')}"
          structure_slug = settings.get_string(slug).strip.parameterize
          structure = ::Binda::Structure.find_by slug: structure_slug
          create_component_and_fields(name, structure_fields, structure)
          structure
            .components
            .where('updated_at < ?', start_time)
            .update_all(publish_state: 'draft')
        end
        ::Binda::Shopify::STRUCTURES.keys
      end

      def create_component_and_fields(name, structure_fields, structure)
        send("fetch_#{name.to_s.pluralize}").each do |item|
          next unless item.id.present?
          component = ::Binda::Component.find_or_initialize_by(
            slug: item.id,
            structure: structure
          )
          component.name ||= item.title
          component.publish_state = 'published'
          component.updated_at = Time.now
          component.save
          create_fields(structure_fields, structure, component, item)
        end
      end

      def create_fields(structure_fields, structure, component, item)
        structure_fields.each do |field_group_slug, fields|
          field_group_slug = "#{structure.slug}-#{field_group_slug}"
          field_group = structure.field_groups.find_by(slug: field_group_slug)
          next unless field_group
          create_field(field_group, fields, component, item)
        end
      end

      def create_field(field_group, fields, component, item)
        fields.each do |field_slug_and_type, method|
          field_slug, type = field_slug_and_type.split(':')
          type ||= 'string'
          next unless ::Binda::Component.reflections.key? type.pluralize
          field_setting = field_group.field_settings.find_by(
            slug: "#{field_group.slug}-#{field_slug}"
          )
          next unless field_setting
          component
            .send(type.pluralize)
            .find_by(field_setting_id: field_setting.id)
            .update(content: item.send(method))
        end
      end

      def fetch(client_source, binda_source)
        items = []
        number_of_pages = (client_source.count / 250.0).ceil
        number_of_pages.times do |i|
          fetched_sources = client_source.find(
            :all,
            params: { limit: 250, page: i + 1 }
          )
          fetched_sources.each do |p|
            items << binda_source.new(p, shop)
          end
        end

        items
      end

      def fetch_collections
        fetch(@client::CustomCollection, ::Binda::Shopify::Collection)
      end

      def fetch_products
        fetch(@client::Product, ::Binda::Shopify::Product)
      end

      def fetch_product_types
        products = fetch_products
        product_types = products.map(&:product_type).uniq
        product_types.map { |p| ::Binda::Shopify::ProductType.new(p, shop) }
      end

      def shop
        @shop ||= @client::Shop.current
      end
    end
  end
end