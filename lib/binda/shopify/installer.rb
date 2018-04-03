module Binda
  module Shopify
    class Installer
      def create_settings_board values
        raise ArgumentError.new 'You must provide an array or hash of settings values' unless values.is_a?(Array) || values.is_a?(Hash)
        values = Hash[(CONNECTION_KEYS+STRUCTURES.keys).zip(values)] if values.is_a? Array
        structure = Binda::Structure.find_or_create_by( name: 'Shopify Settings', slug: 'shopify-settings', instance_type: 'board' )
        board = structure.board
        field_settings = structure.field_groups.first.field_settings
        CONNECTION_KEYS.each do |field_name|
          field_value = values[field_name]
          slug = [structure.slug, field_name.to_s.parameterize].join('-').gsub('_', '-')
          field = field_settings.find_or_create_by( name: field_name.to_s.titleize, slug: slug, field_type: 'string' )
          board.strings.find_or_create_by( field_setting_id: field.id ).update_attribute('content', field_value.strip)
        end

        STRUCTURES.keys.each do |structure_name|
          field_value = values[structure_name]
          slug = [structure.slug, structure_name.to_s.parameterize].join('-').gsub('_', '-')
          field = field_settings.find_or_create_by( name: structure_name.to_s.titleize, slug: slug, field_type: 'string' )
          board.strings.find_or_create_by( field_setting_id: field.id ).update_attribute('content', field_value.strip)
        end

        board
      end

      def create_item_structure structure_name, name
        structure_slug = name.parameterize
        structure = Binda::Structure.find_or_create_by name: name, slug: structure_slug, instance_type: 'component', has_categories: false
        Binda::Shopify::STRUCTURES[structure_name.to_sym].each do |field_group_slug, fields|
          field_group = structure.field_groups.find_by slug: "#{structure_slug}-#{field_group_slug}"
          if field_group.nil?
            field_group = structure.field_groups.create! name: field_group_slug.titleize, slug: "#{structure_slug}-#{field_group_slug}"
          end
          fields.each do |name, mapping|
            field_group.field_settings.create! name: name.titleize, field_type: 'string'
          end
          field_group.save
        end

        structure
      end

    end
  end
end
