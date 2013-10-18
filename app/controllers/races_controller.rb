class RacesController < ApplicationController
  
  before_action :login_check, only:[:show]
 
  # GET /races
  # GET /races.json
  def index
    @races = Race.all
  end

  # GET /races/1
  def show
    if Race.find_by_id(params[:id]) != nil
      @race = Race.find(params[:id],:include => :race_horses)
      @voting_card = nil
      @error = nil
      if VotingCard.find_by(:race_id => params[:id] , :user_id => current_user.id)
        @error = 'すでに登録しています。'
        @voting_card = VotingCard.find_by(:race_id => params[:id] , :user_id => current_user.id)
      end
      #@voting_card = VotingCard.new(voting_card_params)
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_race
      @race = Race.find(params[:id])
    end
    
    # Login Check
    def login_check
      if current_user == nil
        redirect_to :action => 'index'
      end
    end
end
