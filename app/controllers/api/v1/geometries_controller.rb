module Api
  module V1
    class GeometriesController < ApiController
      def tiles
        tile = Geometry.vector_tiles params[:z], params[:x], params[:y], params[:level], params[:'parent-id']
        send_data tile
      end
    end
  end
end
