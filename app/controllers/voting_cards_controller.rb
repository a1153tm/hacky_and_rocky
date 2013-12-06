class VotingCardsController < ApplicationController
  
  #before_action :login_check, only:[:entry]
  #before_action :entry_success_check, only:[:entry]
  #before_action :race_undefined_check, only:[:entry]

  #エレガントにentryを書くための練習・・・
  def test_entry
    @voting_card = VotingCard.new(voting_card_params)
    @race = Race.find(params[:id] , :include => :race_horses)
    params[:vote_item].each_width_index do |(i,v)|
      vote_item = VoteItem.new()
      vote_item.voting_card = @voting_card
    end
  end
  
  #投票データを格納する。
  #route POST race/:id/voting_cards
  def vote
    flash[:error] = "投票する前にログインしてください。" unless user = current_user
    flash[:error] = "レースが存在しません。" unless @race = Race.find(params[:id])
    if @race and user and VotingCard.find_by(:race_id => @race.id, :user_id => current_user.id)
      flash[:error] = "このレースは投票済みです。"
    end

    unless flash[:error]
      card = VotingCard.new(:race_id => @race.id, :user_id => current_user.id, :vote_date => Time.now)
      vote_params = params[:vote_item]
      vote_item = VoteItem.new(voting_card: card, race_horse_id: vote_params[:horse], point_weight: vote_params[:amount])
      card.vote_items << vote_item
      begin
        user.point -= vote_item.point_weight.to_i
        VotingCard.transaction do
          card.save!
          user.save!
        end
      rescue => e
        logger.error e.to_s
        logger.error ''
        flash[:error] = "投票できませんでした。"
      end
    end

    unless flash[:error]
      redirect_to race_progress_path(@race, :current)
    else
      render 'races/show'
    end
  end
  
end
