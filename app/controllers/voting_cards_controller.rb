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
  def entry
    flash[:error] = "投票する前にログインしてください。" unless current_user
    flash[:error] = "レースが存在しません。" unless @race = Race.find(params[:id])
    flash[:error] = "このレースは投票済みです。" if VotingCard.find_by(:race_id => @race.id, :user_id => current_user.id)

    card = VotingCard.new(:race_id => @race.id , :user_id => current_user.id, :vote_date => Time.now)
    params[:vote_items].each do |(horse_id,weight)|
      if weight and !weight.empty?
        card.vote_items << VoteItem.new(race_horse_id: horse_id, point_weight: weight)
      end
    end

    if flash[:error].nil? and card.save!()
      redirect_to race_progress_path(@race, :last)
    else
      redirect_to @race
    end
  end
  
end
