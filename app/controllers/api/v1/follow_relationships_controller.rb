class Api::V1::FollowRelationshipsController < ApiController
  wrap_parameters :favorite, include: [:following_id, :follower_id]

  def create
    # relation_ship = FollowRelationship.build(following_id: params[:following_id], follower_id: params[:follower_id])
    # render json: relation_ship
    user = User.find_by(id: params[:follower_id])
    other_user = User.find_by(id: params[:following_id])
    # user.follow(other_user)
    follow_relationship = FollowRelationship.create(follower_id: user.id, following_id: other_user.id)
    render json: follow_relationship
    # respond_to do |format|
    #   format.html { redirect_back(fallback_location: root_url) }
    #   format.js
    # end
  end
  # def follow(other_user)
  #   self.following_relationships.create(following_id: other_user.id)
  # end

  def destroy
    @user = User.find(params[:follow_relationship][:following_id])
    current_user.unfollow(@user)
    respond_to do |format|
      format.html { redirect_back(fallback_location: root_url) }
      format.js
    end
  end
end
