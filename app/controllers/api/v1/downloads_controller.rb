module Api
  module V1
    class DownloadsController < ApiController
      before_action :check_param, only: :show
      def show
        send_file(@download_url)
        rescue not_found
      end
      private
      def check_param
        not_found unless params[:id] =~ (/[a-z]_*$/)
        @download_url = "#{Rails.root}/public/downloads/states/#{params[:id]}.csv"
      end
      def not_found
        raise ActionController::RoutingError.new('Not Found')
      end
    end
  end
end
