require_dependency "binda/application_controller"

module Binda
  module Shopify
    class ImportsController < ::Binda::ApplicationController
      def import
        importer = Binda::Shopify::Importer.new
        importer.run!

        structure_name = STRUCTURES.keys.first
        settings = Binda::Structure.find_by(slug: 'shopify-settings').board
        structure_slug = settings.get_string("#{settings.slug}-#{structure_name.to_s.gsub('_', '-')}").strip.parameterize
        structure = Binda::Structure.find_by slug: structure_slug
        redirect_to binda.structure_components_path( structure ), notice: 'Import was succesful!'
      end
    end
  end
end
