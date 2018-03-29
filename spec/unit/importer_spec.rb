require 'rails_helper'

describe "Binda::Shopify::Importer" do
  before(:all) do
    settings = { api_key: 'aaa', password: 'bbb', shared_secret: 'ccc', shop_name: 'ddd', product: 'Product', collection: 'Collection', product_type: 'Product Type' }
    installer = Binda::Shopify::Installer.new
    installer.create_settings_board(settings)
    installer.create_item_structure :product, 'Product'
    installer.create_item_structure :product_type, 'Product Type'
    installer.create_item_structure :collection, 'Collection'
  end

  let(:importer){ Binda::Shopify::Importer.new }
  let(:shop_fixture){ JSON.parse ShopifyAPI::Mock::Fixture.find(:shop, :json).data, symbolize_names: true }
  let(:product_fixtures){ JSON.parse ShopifyAPI::Mock::Fixture.find(:products, :json).data, symbolize_names: true }
  let(:collection_fixtures){ JSON.parse ShopifyAPI::Mock::Fixture.find(:custom_collections, :json).data, symbolize_names: true }

  it "connects to shopify" do
    expect(importer.shop.name).to eq('Apple Computers')
  end

  it "imports products" do
    importer.run!

    product_fixtures[:products].each do |product|
      expect(Binda::Component.find_by slug: product[:id]).to_not eq nil
    end
  end

  it "doesn't duplicate products" do
    importer.run!
    importer.run!
    expect(Binda::Component.where(slug: product_fixtures[:products].first[:id]).count).to eq 1
  end

  it "imports collections" do
    importer.run!

    collection_fixtures[:custom_collections].each do |collection|
      expect(Binda::Component.find_by slug: collection[:id]).to_not eq nil
    end
  end

  it "doesn't duplicate collections" do
    importer.run!
    importer.run!
    expect(Binda::Component.where(slug: collection_fixtures[:custom_collections].first[:id]).count).to eq 1
  end

  it "imports product types" do
    product_types = product_fixtures[:products].map{ |product| product[:product_type] }
    importer.run!
    product_types.each do |product_type|
      expect(Binda::Component.where(name: product_type).count).to eq 1
    end
  end
end
