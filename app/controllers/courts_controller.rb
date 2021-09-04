class CourtsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :destroy]

  def new
    @court = Court.new
  end

  def show
    @court = Court.find(params[:id])
  end

  def create
    @court = Court.new(court_params)
    if @court.save
      flash[:success] = "コート情報を受け付けました！"
      redirect_back_or @user
    else
      render 'new'
    end
  end

  def destroy
  end

  private

    def court_params
      params.permit(:name, :address)
    end

    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "ログインをお願いします。"
        redirect_to login_url
      end
    end
end
