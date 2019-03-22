class ApiController < ApplicationController
  #respond_to :json, :xml
  before_action :set_format, :verify_key

  def import
    d = JSON.parse(params[:day])
    day = Day.new(d)
    day.save
  end

  private

  def set_format
    request.format = :json unless params[:format].present?
  end

  def verify_key
    authenticate_or_request_with_http_token do |token, options|
      ENV['OYB_API_KEY'] == token
    end
  end

end
