module Api
  module V1
    class GeometriesController < ApiController
      def tiles
        tile = Geometry.vector_tiles params[:z], params[:x], params[:y], params[:level], params[:'parent-id']
        set_cache_control_headers
        send_data tile
      end

      private

      def set_cache_control_headers(max_age = 1.month.to_i)
        response.headers['Cache-Control'] = 'public, no-cache'
        response.headers['Surrogate-Control'] = "max-age=#{max_age}"
      end
    end
  end
end
