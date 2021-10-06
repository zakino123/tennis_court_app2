class FavoritesController < ApplicationController
  before_action :set_court, only: %i[create destroy]
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
