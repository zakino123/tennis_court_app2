class GuestSessionsController < ApplicationController
  def create
    user = User.find_or_create_by(email: "guest@exapmle.com") do |user|
      user.password = "foobar"
      user.name = "ゲスト"
    end
      session[:user_id] = user.id
      flash[:success] = "ゲストログインしました"
      redirect_back_or user
  end
end
