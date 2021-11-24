class Api::V1::CommentsController < ApiController
  wrap_parameters :comment, include: [:context, :court_id, :user_id]

  def comment_count
    comment_count = Comment.where(court_id: params[:id]).count
    render json: comment_count
  end

  def create
    comment = Comment.new(comment_params)
    if comment.save
      render json: comment
    else
      render json: { message: 'コメント投稿出来ませんでした'}
    end
  end

  def destroy
    comment = Comment.find_by(court_id: params[:court_id], user_id: params[:user_id])
    comment.destroy
    render json: { status: "SUCCESS", message: "コメントは削除されました", data: comment }
  end

  private

  def comment_params
    params.require(:comment).permit(:context).merge(user_id: params[:user_id], court_id: params[:court_id])
  end
end
