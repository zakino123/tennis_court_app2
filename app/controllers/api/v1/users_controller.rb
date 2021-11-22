class Api::V1::UsersController < ApiController
  before_action :set_user, only: %i[show]
  wrap_parameters :user, include: [:name, :email, :password, :password_confirmation]

  def new
    user = User.new
  end

  def index
    users = User.all.page(params[:page]).per(12)
    render json: users
  end

  def show
    # user = User.find(params[:id])
    # @courts = @user.courts.page(params[:page]).per(3)
    # favorites = Favorite.where(user_id: @user.id).order(created_at: :desc).pluck(:court_id)
    # @favorites = Court.page(params[:page]).per(3).find(favorites)
    # render json: @user.as_json(include: :court)
    render json: @user
  end

  def favorite_court
    user = User.find(params[:id])
    favorites = Favorite.where(user_id: user.id).order(created_at: :desc).pluck(:court_id)
    favorite_court = Court.page(params[:page]).per(3).find(favorites)
    render json: favorite_court.as_json(include: :user)
  end

  def post_court
    user = User.find(params[:id])
    post_court = user.courts.page(params[:page]).per(3)
    render json: post_court.as_json(include: :user)
  end

  def create
    user = User.new(user_params)
    user.image = "default.jpg"
    if user.save
      # log_in @user
      # flash[:success] = 'テニスコートサーチにようこそ！'
      # redirect_back_or @user
      render json: user
    else
      render json: { message: '登録できませんでした'}
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    user = User.find(params[:id])
    if user.update(user_params)
      flash[:success] = 'アカウント情報を更新しました。'
      redirect_to uuser
    else
      render json: { message: 'ユーザー更新できませんでした'}
    end
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    render json: { status: "SUCCESS", message: "ユーザー情報は削除されました", data: user }
  end

  def following
    @user = User.find(params[:id])
    @users = @user.followings.page(params[:page]).per(12)
  end

  def followers
    @user = User.find(params[:id])
    @users = @user.followers.page(params[:page]).per(12)
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :image)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
end
