class Api::V1::ApplicationController < ApiController
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
