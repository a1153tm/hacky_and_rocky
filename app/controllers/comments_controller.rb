class CommentsController < ApplicationController
  
  #post /comment/insert/
  def create
    logger.debug params[:comment]
    comment = Comment.new
    comment.comment = params[:comment][:comment]
    comment.user_id = params[:comment][:user_id]
    comment.race_id = params[:race_id]
    comment.save!
    @comment = Comment.new
    @comment.user_id = current_user.id
    @race = Race.find(params[:race_id])
    respond_to do |format|
      format.html { render :layout => false }
    end
  end
  
end
