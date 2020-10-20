class DashboardController < ApplicationController
  before_action :authorize_user

  def index
  end

  def update
    @user = current_user
    @user.update(api_bible_key: params[:user][:api_bible_key], config: params[:user][:config].as_json)
    bust_cache
    redirect_to dashboard_path, notice: "Successfully updated settings."
  end

  private

  def authorize_user
    redirect_to root_path unless current_user.present?
  end

  def bust_cache
    Rails.cache.delete("versions-#{current_user.token}")
    Rails.cache.delete("user-#{current_user.token}")
  end

  def user_params
    params.require(:user).permit(:api_bible_key, config: [:versions])
  end

end
