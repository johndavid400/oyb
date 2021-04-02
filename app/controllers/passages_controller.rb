class PassagesController < ApplicationController

  before_action :find_day, only: [:get_passages]

  def get_passages
    params[:bible] ||= get_version
    render :json => @day.get_passages(params).to_json
  end

  private

  def find_day
    @day = params[:day].present? ? Day.find_by(id: params[:day]) : Day.today
  end

  def get_version
    Rails.cache.fetch("tokens/#{params[:token]}/version", expires_in: 1.hour) do
      User.find_by(token: params[:token])&.versions&.first
    end
  rescue
    nil
  end

end

