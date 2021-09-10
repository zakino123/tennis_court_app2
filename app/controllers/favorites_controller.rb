class FavoritesController < ApplicationController
  before_action :set_court, only: [:create, :destroy]
  # def create
  #   @court = Court.find(params[:court_id])
  #   if @court.user_id != current_user.id
  #     @favorite = Favorite.create(user_id: current_user.id, court_id: @court.id)
  #   end
  # end
  # def destroy
  #   @court = Court.find(params[:court_id])
  #   @favorite = Favorite.find_by(user_id: current_user.id, court_id: @court.id)
  #   @favorite.destroy
  # end
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
