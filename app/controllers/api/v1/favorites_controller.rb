class Api::V1::FavoritesController < ApiController
  before_action :set_court, only: %i[create destroy]
  def favorite_count
    favorite_count = Favorite.where(court_id: params[:id]).count
    render json: favorite_count
  end

  def create
    @favorite = current_user.favorites.create(court_id: params[:court_id])
    redirect_to court_path(@court)
  end

  def destroy
    @favorite = current_user.favorites.find_by(court_id: @court.id)
    @favorite.destroy
    redirect_to court_path(@court)
  end

  private

  def set_court
    @court = Court.find(params[:court_id])
  end
end
