module Binda
  module Shopify
    class InstallGenerator < Rails::Generators::Base
      attr_accessor :structure

      def create_structure
        @structure = Binda::Structure.create name: 'Shopify Product', instance_type: 'component'
      end

      def add_field_settings
        field_group = structure.field_groups.first
        { 'SKU' => 'string', 'Description' => 'string' }.each do |name, field_type|
          field_group.field_settings << Binda::FieldSetting.new(name: name, field_type: field_type)
        end
        field_group.save
      end
    end
  end
end
