class Api::V1::FavoritesController < ApiController
  before_action :set_court, only: %i[create destroy]
  wrap_parameters :favorite, include: [:court_id, :user_id]
  def favorite_count
    favorite_count = Favorite.where(court_id: params[:id]).count
    render json: favorite_count.as_json(include: :court)
  end

  def create
    favorite = Favorite.create(user_id: params[:user_id], court_id: params[:court_id])
    render json: favorite
  end

  def destroy
    favorite = Favorite.find_by(court_id: @court.id)
    favorite.destroy
    render json: favorite
  end

  private

  def set_court
    @court = Court.find(params[:court_id])
  end
end
