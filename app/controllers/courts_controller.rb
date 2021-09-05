class CourtsController < ApplicationController
  before_action :logged_in_user, only: [:new, :edit, :create, :destroy]
  before_action :permit_update_delete, only: [:edit]


  def new
    @court = Court.new
  end

  def show
    @court = Court.find(params[:id])
  end

  def edit
    @court = Court.find(params[:id])
  end

  def create
    @court = current_user.courts.new(court_params)
    if @court.save
      flash[:success] = "コート情報を受け付けました！"
      redirect_back_or root_path
    else
      render 'new'
    end
  end

  def destroy
    Court.find(params[:id]).destroy
    flash[:success] = "コート情報を削除しました。"
    redirect_to root_url
  end

  private

    def court_params
      params.require(:court).permit(:name, :address)
    end

    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "ログインをお願いします。"
        redirect_to login_url
      end
    end

    def permit_update_delete
      @court = Court.find(params[:id])
      unless @court.user_id == current_user.id or current_user.admin
        flash[:notice] = "投稿者以外の編集・削除はできません。"
        redirect_to root_path
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
