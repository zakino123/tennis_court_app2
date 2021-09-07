class CourtsController < ApplicationController
  before_action :logged_in_user, only: [:new, :edit, :create, :destroy]
  before_action :permit_update_delete, only: [:edit]


  def new
    @court = Court.new
  end

  def show
    @court = Court.find(params[:id])
  end

  def index
  end

  def search
    results = Geocoder.search(params[:location])
    if results.empty?
      flash[:notice] = "検索フォームに文字が入っていないか、位置情報を取得できる値でない可能性があります。"
      redirect_to root_path
    else
      selection = params[:keyword]
      latitude = results.first.coordinates[0]
      longitude = results.first.coordinates[1]
      courts = Court.within_box(20, latitude, longitude)
      case selection
      when 'near'
        @courts = Court.near(results.first.coordinates, 20).page(params[:page]).per(10)
      else
        @courts = courts
      end
    end
  end

  def edit
    @court = Court.find(params[:id])
  end

  def create
    @court = current_user.courts.new(court_params)
    if @court.save
      flash[:success] = "コート情報を受け付けました！"
      redirect_to @court
    else
      render 'new'
    end
  end

  def update
    @court = Court.find(params[:id])
    if @court.update(court_params)
      flash[:success] = "アカウント情報を更新しました。"
      redirect_to @court
    else
      render 'edit'
    end
  end

  def destroy
    Court.find(params[:id]).destroy
    flash[:success] = "コート情報を削除しました。"
    redirect_to root_url
  end

  private

    def court_params
      params.require(:court).permit(:name, :address, :price, :hour, :image, :number, :remarks, :latitude, :longitude)
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
