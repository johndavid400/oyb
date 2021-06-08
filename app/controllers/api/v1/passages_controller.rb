module Api
  module V1
    class PassagesController < ::Api::BaseController

      before_action :find_day, only: [:get_passages]

      def get_passages
        params[:bible] ||= get_version
        params[:token] = @user.token
        render :json => @day.get_passages_api(params).to_json
      end

      private

      def get_version
        Rails.cache.fetch("tokens/#{@user.token}/version", expires_in: 1.hour) do
          @user&.versions&.first
        end
      end
    end
  end
end
