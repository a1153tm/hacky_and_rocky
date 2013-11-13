class CommentController < ApplicationController
  
  #post /comment/insert/
  def insert
    flash[:error] = "投票する前にログインしてください。" unless user = current_user
    flash[:error] = "レースが存在しません。" unless race = Race.find(params[:id])
    
    unless flash[:error]     
      comment = Comment.new(params[:race_id], params[:user_id], params[:comment])
      begin
        Commnent.trunsaction do
          comment.save!
        end
      rescue => e
        flash[:error] = "書き込みが出来ませんでした。"
      end
    end
    
  end
  
  #post /comment/show/
  def show
    
  end
  
  private
  def ajax_html_display
    
  end
  
end
