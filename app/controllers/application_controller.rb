class ApplicationController < ActionController::Base
  before_action :set_cors_header

  def set_cors_header
    response.set_header('Access-Control-Allow-Origin', '*')
  end

end
