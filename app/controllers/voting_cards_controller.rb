class VotingCardsController < ApplicationController
  
  #before_action :login_check, only:[:entry]
  before_action :entry_success_check, only:[:entry]
  before_action :race_undefined_check, only:[:entry]

  

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
  #route POST race/:id
  def entry
    if current_user
      @race = Race.find(params[:id], :include => :race_horses)
      begin
        ActiveRecord::Base.transaction do
          @voting_card = VotingCard.new(:race_id => @race.id , :user_id => current_user.id, :vote_date => Time.now)
          if @voting_card.save!
            @voting_card = VotingCard.find(:last)
            for i in 1..@race.race_horses.size
              voteItem = VoteItem.new(:voting_card_id => @voting_card.id,:race_horse_id => params['horse_id'+ i.to_s ],:point_weight => params['point_weight'+ i.to_s ])
              voteItem.save!
            end
          end
        end
        #vote_item登録成功時の処理
        @error = 'あなたの投票状況です。'
        render 'races/show'
      rescue
        #登録失敗時
        @error = '登録できませんでした'
        render 'races/show'
      end
    else
      redirect_to :controller => 'races' , :action => 'index'
    end
  end
  
  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def voting_card_params
      params.require(:voting_card).permit(:vote_date,:race_id,:user_id)
    end
    
    # Login Check
    def login_check
      if current_user != nil
      else
        redirect_to :controller => 'races' , :action => 'index'
      end
    end
    
    #エントリー済
    def entry_success_check
      if current_user
        if VotingCard.find_by(:race_id => params[:id] , :user_id => current_user.id)
          redirect_to :controller => 'races' , :action => 'index'
        end
      else
        redirect_to :controller => 'races' , :action => 'index'
      end
    end
    
    #レースが無かった時
    def race_undefined_check
      if Race.find_by_id(params[:id]) == nil
        redirect_to :controller => 'races' , :action => 'index'
      end
    end
end