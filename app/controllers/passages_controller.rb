class PassagesController < ApplicationController

  before_action :find_day, only: [:get_passages]

  def get_passages
    render :json => @day.get_passages(params).to_json
  end

  private

  def find_day
    @day = params[:day].present? ? Day.find_by(id: params[:day]) : Day.today
  end

end

