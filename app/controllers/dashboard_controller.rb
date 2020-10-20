class DashboardController < ApplicationController

  def index
  end

  def update
    @user = current_user
    @user.update(api_bible_key: params[:user][:api_bible_key], config: params[:user][:config].as_json)
    redirect_to dashboard_path, notice: "Successfully updated settings."
  end

  private

  def user_params
    params.require(:user).permit(:api_bible_key, config: [:versions])
  end

end
