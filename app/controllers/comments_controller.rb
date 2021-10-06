class CommentsController < ApplicationController
  before_action :logged_in_user, only: %i[create destroy]

  def create
    @court = Court.find(params[:court_id])
    @comment = Comment.new(comment_params)
    if @comment.save
      flash[:success] = 'コメントを投稿しました！'
      redirect_to @court
    else
      flash[:danger] = '投稿に失敗しました！'
      render 'courts/index'
    end
  end

  def destroy
    @court = Court.find(params[:court_id])
    Comment.find_by(id: params[:id], court_id: params[:court_id]).destroy
    flash[:success] = 'コメントを削除しました。'
    redirect_to @court
  end

  private

  def comment_params
    params.require(:comment).permit(:context).merge(user_id: current_user.id, court_id: params[:court_id])
  end
end
