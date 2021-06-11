module Api
  class BaseController < ::ActionController::Base #::ApplicationController
    respond_to :json
    before_action :verify_key, :set_format
    protect_from_forgery

    private

    def set_format
      request.format = :json unless params[:format].present?
    end

    def verify_key
      authenticate_or_request_with_http_token do |token, options|
        return invalid_key unless User.exists?(api_key: token)

        @user = User.find_by(api_key: token)
      end
    end

    def invalid_key
      render json: {error: 'Unauthorized', message: 'API key is invalid'}, status: :unauthorized
    end

    def find_day
      return find_day_by_id if params[:day].present?
      return find_day_by_month_and_day if params[:month_of_year].present? && params[:day_of_month].present?

      @day = Day.today
    end

    def find_day_by_id
      @day = Day.find_by(id: params[:day]) || Day.today
    end

    def find_day_by_month_and_day
      @day = Day.find_by(month_of_year: params[:month_of_year], day_of_month: params[:day_of_month]) || Day.today
    end
  end
end
