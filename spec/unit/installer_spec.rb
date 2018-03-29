require 'rails_helper'

describe "Binda::Shopify::Installer" do
  let(:installer){ Binda::Shopify::Installer.new }
  let(:values_array){ ['aaa', 'bbb', 'ccc', 'ddd', 'Product', 'Collection', 'Product Type'] }
  let(:values){ { api_key: 'aaa', password: 'bbb', shared_secret: 'ccc', shop_name: 'ddd', product: 'Product', collection: 'Collection', product_type: 'Product Type' } }

  context "create_shopify_settings" do

    it "creates a board for shopify settings given an array" do
      expect{ installer.create_settings_board(values_array) }.to change{ Binda::Structure.count }.by 1
    end

    it "creates a board for shopify settings given an hash" do
      expect{ installer.create_settings_board(values) }.to change{ Binda::Structure.count }.by 1
    end

    it "raises ArgumentError if values is not Array or Hash" do
      wrong_values = 'aaa,bbb,ccc,ddd'
      expect{ installer.create_settings_board(wrong_values) }.to raise_error(ArgumentError)
    end

    it "adds the right fields to the settings board" do
      installer.create_settings_board(values)
      board = Binda::Structure.find_by(slug: 'shopify-settings').try(:board)
      expect(board).not_to be nil
      values.each do |key, value|
        expect(board.get_string("shopify-settings-#{key.to_s.gsub('_', '-')}")).to eq(value)
      end
    end

    it "doesn't duplicate the board when executed multiple times" do
      expect{ 5.times{ installer.create_settings_board(values) } }.to change{ Binda::Board.count }.by 1
    end

  end

  context "create products structure" do
    it "creates a structure for products" do
      installer.create_settings_board(values)
      expect{ installer.create_item_structure :product, 'Shopify Item' }.to change{ Binda::Structure.count }.by 1
    end

    it "doesn't duplicate the structure when executed multiple times" do
      installer.create_settings_board(values)
      expect{ 5.times{ installer.create_item_structure :product, 'Shopify Item' } }.to change{ Binda::Structure.count }.by 1
    end

    it "adds the right field settings to the structure" do
      installer.create_settings_board(values)
      name = 'Shopify Item'
      installer.create_item_structure :product, name

      structure = Binda::Structure.find_by slug: 'shopify-item'
      expect(structure).not_to be nil
      Binda::Shopify::STRUCTURES[:product].each do |field_group_slug, fields|
        field_group = structure.field_groups.find_by slug: "shopify-item-#{field_group_slug}"
        expect(field_group).not_to be nil
        fields.each do |field_slug, mapping|
          slug = "shopify-item-#{field_group_slug}-#{field_slug}"
          field_setting = field_group.field_settings.find_by slug: slug
          expect(field_setting).not_to be_nil
          expect(field_setting.field_type).to eq 'string'
        end
      end
    end
  end
  
  context "create collections structure" do
    it "creates a structure for collections" do
      installer.create_settings_board(values)
      expect{ installer.create_item_structure :collection, 'Shopify Collection' }.to change{ Binda::Structure.count }.by 1
    end

    it "doesn't duplicate the structure when executed multiple times" do
      installer.create_settings_board(values)
      expect{ 5.times{ installer.create_item_structure :collection, 'Shopify Collection' } }.to change{ Binda::Structure.count }.by 1
    end

    it "adds the right field settings to the structure" do
      installer.create_settings_board(values)
      name = 'Shopify Collection'
      installer.create_item_structure :collection, name

      structure = Binda::Structure.find_by slug: 'shopify-collection'
      expect(structure).not_to be nil
      Binda::Shopify::STRUCTURES[:collection].each do |field_group_slug, fields|
        field_group = structure.field_groups.find_by slug: "shopify-collection-#{field_group_slug}"
        expect(field_group).not_to be nil
        fields.each do |field_slug, mapping|
          slug = "shopify-collection-#{field_group_slug}-#{field_slug}"
          field_setting = field_group.field_settings.find_by slug: slug
          expect(field_setting).not_to be_nil
          expect(field_setting.field_type).to eq 'string'
        end
      end
    end
  end

  context "create product types structure" do
    it "creates a structure for product types" do
      installer.create_settings_board(values)
      expect{ installer.create_item_structure :product_type, 'Shopify Product Type' }.to change{ Binda::Structure.count }.by 1
    end

    it "doesn't duplicate the structure when executed multiple times" do
      installer.create_settings_board(values)
      expect{ 5.times{ installer.create_item_structure :product_type, 'Shopify Product Type' } }.to change{ Binda::Structure.count }.by 1
    end

    it "adds the right field settings to the structure" do
      installer.create_settings_board(values)
      name = 'Shopify Product Type'
      installer.create_item_structure :product_type, name

      structure = Binda::Structure.find_by slug: 'shopify-product-type'
      expect(structure).not_to be nil
      Binda::Shopify::STRUCTURES[:product_type].each do |field_group_slug, fields|
        field_group = structure.field_groups.find_by slug: "shopify-product-type-#{field_group_slug}"
        expect(field_group).not_to be nil
        fields.each do |field_slug, mapping|
          slug = "shopify-product-type-#{field_group_slug}-#{field_slug}"
          field_setting = field_group.field_settings.find_by slug: slug
          expect(field_setting).not_to be_nil
          expect(field_setting.field_type).to eq 'string'
        end
      end
    end
  end

end

