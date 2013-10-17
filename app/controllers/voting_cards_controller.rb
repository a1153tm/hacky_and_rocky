class VotingCardsController < ApplicationController
  
  #投票データを格納する。
  def entry
    
    @horseNumberColors = ['white','black','red','blue','orange','green','pink','skyblue','yellow','limegreen']
    @error = nil
    
    if Race.find_by_id(params[:id]) != nil #&& current_user != false
      
      @race = Race.find(params['race_id'] , :include => :race_horses)
      votingCard = VotingCard.new(:race_id => @race.id , :user_id => '1', :vote_date => Time.now)
      
      if votingCard.save
        begin
          votingCard = VotingCard.find(:last)
          ActiveRecord::Base.transaction do
            for i in 1..@race.race_horses.size - 1
              if params['horse_' + i.to_s].length > 0 
               voteItem = VoteItem.new(
                        :voting_card_id => votingCard.id,
                        :race_horse_id => params['horse_id_'+ i.to_s ],
                        :point_weight => params['point_weight'+ i.to_s ])
                voteItem.save!
              end
            end
          end
          @error = '登録できました。'
          render 'races/show'
        rescue
          @error = '登録できませんでした。'
          render 'races/show'
        end
      else
        @error = '登録できませんでした。'
        render 'races/show'
      end

    else
      redirect_to :controller => 'races' , :action => 'index'
    end
    
  end
  
end

