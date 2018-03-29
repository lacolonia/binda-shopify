module Binda
  module Shopify
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('../templates',__FILE__)
      attr_accessor :structure

      def start
        puts "Ok, let'do this!"
      end

      def create_shopify_settings
        puts "1) Setting up Shopify Connection"
        @installer = Installer.new
        @settings = {}
        Binda::Shopify::CONNECTION_KEYS.each do |field_name|
          STDOUT.puts "What is your Shopify #{field_name.to_s.titleize}?"
          @settings[field_name] = STDIN.gets.strip
        end
        Binda::Shopify::STRUCTURES.each do |structure_name, structure_fields|
          default_name = "Shopify #{structure_name.to_s.titleize}"
          puts "How would you like to name your #{structure_name} structure? ['#{default_name}']"
          @settings[structure_name] = STDIN.gets.strip.presence || default_name
        end
        @settings_board = @installer.create_settings_board @settings
        puts
      end

      def setup_structures 
        Binda::Shopify::STRUCTURES.each.with_index do |(structure_name, structure_fields), index|
          name = @settings[structure_name].presence || structure_name.to_s.titleize
          puts "#{index+2}) Setting up #{name} Structure"
          @installer.create_item_structure structure_name, name
          puts
        end
      end

      def finish
        puts "Done!"
        puts
      end

    end
  end
end
