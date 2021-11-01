module Api
  module V1
    class ApiController < ActionController::API
      include SessionsHelper

      private

      def logged_in_user
        unless logged_in?
          store_location
          flash[:danger] = 'ログインをお願いします。'
          redirect_to login_url
        end
      end
    end
  end
end