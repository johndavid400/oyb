module Api
  module V1
    class UsersController < ::Api::BaseController
      def versions
        render :json => @user.available_versions.to_json
      end
    end
  end
end
