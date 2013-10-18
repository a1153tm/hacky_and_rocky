class RacesController < ApplicationController
  
  # GET /races
  # GET /races.json
  def index
    @races = Race.all
  end
  
  def top
    @races = Race.find(:all,:conditions => ['end_date > ?' , Time.now])
    render "races/top"
  end

  # GET /races/1
  def show
    if Race.find_by_id(params[:id]) != nil && current_user != nil
      @race = Race.find(params[:id],:include => :race_horses)
      @voting_card = nil
      @error = nil
      if VotingCard.find_by(:race_id => @race.id, :user_id => current_user.id)
        @error = 'すでに登録しています。'
        @voting_card = VotingCard.find_by(:race_id => @race.id, :user_id => current_user.id)
      end
    else
      redirect_to :controller => 'races' , :action => 'index'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_race
      @race = Race.find(params[:id])
    end
end
