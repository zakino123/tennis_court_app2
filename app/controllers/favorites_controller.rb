class FavoritesController < ApplicationController
  def create
    @court = Court.find(params[:court_id])
    if @court.user_id != current_user.id
      @favorite = Favorite.create(user_id: current_user.id, court_id: @court.id)
    end
  end
  def destroy
    @court = Court.find(params[:court_id])
    @favorite = Favorite.find_by(user_id: current_user.id, court_id: @court.id)
    @favorite.destroy
  end
end
