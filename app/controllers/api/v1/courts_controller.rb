class Api::V1::CourtsController < ApiController
  # before_action :logged_in_user, only: %i[destroy]
  wrap_parameters :court, include: [:name, :tag_name, :address, :latitude, :longitude, :price, :image, :number, :remarks, :reserve, :user_id]

  def new
    court = Court.new
  end

  def court_tag
    court = Court.find(params[:id])
    court_tags = court.tags
    render json: court_tags
  end

  def show
    court = Court.find(params[:id])
    # gon.court = court
    render json: court.as_json(include: :user)
    # @court_tags = @court.tags
    # @comment = Comment.new
    # @comments = @court.comments.includes(:user).page(params[:page])
    # @favorite = Favorite.new
  end

  def court_comment
    court = Court.find(params[:id])
    court_comment = court.comments.includes(:user).page(params[:page])
    render json: court_comment.as_json(include: :user)
  end

  def taglist
    taglist = Tag.all.page(params[:page])
    render json: taglist
  end

  def court_rank
    court_rank = Court.includes(:user).unscope(:order).find(Favorite.group(:court_id).order('count(court_id) desc').limit(4).pluck(:court_id))

    render json: court_rank.as_json(include: :user)
  end

  def latest_court
    latest_court = Court.includes(:user).order(created_at: :desc).limit(4)
    render json: latest_court.as_json(include: :user)
  end

  def index
    # @tag_list = Tag.all.page(params[:page])
    courts = Court.all.page(params[:page]).per(12)
    render json: courts.as_json(include: :user)
    # all_ranks = Court.includes(:user).unscope(:order).find(Favorite.group(:court_id).order('count(court_id) desc').limit(4).pluck(:court_id))
    # latest_courts = Court.includes(:user).order(created_at: :desc).limit(4)
    
    # render json: {latest_courts: latest_courts, all_ranks: all_ranks}
    
    # jsonHash = [ all_ranks, latest_courts ]

    # render json: jsonHash
    
  end

  def search
    # @tag_list = Tag.all
    results = Geocoder.search(params[:location])
    if results.empty?
      render json: { message: 'コート情報を取得できませんでした'}
    else
      # selection = params[:keyword]
      latitude = results.first.coordinates[0]
      longitude = results.first.coordinates[1]
      courts = Court.within_box(20, latitude, longitude)
      # search_courts = case selection
      #           when 'near'
      #             Court.near(results.first.coordinates, 20).page(params[:page]).per(12)
      #           when 'inexpensive'
      #             courts.order(price: :asc).page(params[:page]).per(12)
      #           when 'number'
      #             courts.order(number: :desc).page(params[:page]).per(12)
      #           else
      #             courts.page(params[:page]).per(12)
      #           end
      search_courts = courts.page(params[:page]).per(12)
      render json: search_courts.as_json(include: :user)
    end
  end

  def tagsearch
    tag = Tag.find(params[:id])
    courts = tag.courts.all.page(params[:page]).per(12)

    render json: courts.as_json(include: :user)
  end

  def edit
    court = Court.find(params[:id])
  end

  def create
    court = Court.new(court_params)
    tag_list = params[:court][:tag_name].split(nil)
    if court.save!
      court.save_tag(tag_list)
      # flash[:success] = 'コート情報を受け付けました！'
      # redirect_to @court
      render json: court
    else
      render json: { message: 'コート投稿出来ませんでした'}
    end
  end

  def update
    court = Court.find(params[:id])
    # tag_list = params[:court][:tag_name].split(nil)
    if court.update(court_params)
      # @court.save_tag(tag_list)
      # flash[:success] = 'アカウント情報を更新しました。'
      # redirect_to @court
      render json: court
    else
      render json: { message: 'コート投稿出来ませんでした'}
    end
  end

  def destroy
    court = Court.find(params[:id])
    court.destroy
    render json: { status: "SUCCESS", message: "コート情報は削除されました", data: court }
  end

  private

  def court_params
    params.require(:court).permit(:name, :address, :price, :hour, :image, :number, :remarks, :latitude, :longitude, :reserve, :user_id)
  end

  def logged_in_user
    unless logged_in?
      store_location
      # flash[:danger] = 'ログインをお願いします。'
      redirect_to login_url
    end
  end

  def permit_update_delete
    @court = Court.find(params[:id])
    unless (@court.user_id == current_user.id) || current_user.admin
      flash[:notice] = '投稿者以外の編集・削除はできません。'
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
