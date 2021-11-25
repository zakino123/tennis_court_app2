class Api::V1::FollowRelationshipsController < ApiController
  wrap_parameters :favorite, include: [:following_id, :follower_id]

  def follow_count
    follow_count = FollowRelationship.where(follower_id: params[:id]).count
    render json: follow_count
  end

  def show
    follow = FollowRelationship.find_by(follower_id: params[:follower_id], following_id: params[:following_id])
    render json: follow
  end

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

  def destroy
    user = User.find_by(id: params[:follower_id])
    other_user = User.find_by(id: params[:following_id])
    # follow_relationship = FollowRelationship.destroy(follower_id: user.id, following_id: other_user.id)
    follow_relationship = FollowRelationship.find_by(follower_id: user.id, following_id: other_user.id)
    follow_relationship.destroy
    render json: follow_relationship


    # current_user.unfollow(@user)
    # respond_to do |format|
    #   format.html { redirect_back(fallback_location: root_url) }
    #   format.js
    # end
  end
  # def unfollow(other_user)
  #   self.following_relationships.find_by(following_id: other_user.id).destroy
  # end
end
