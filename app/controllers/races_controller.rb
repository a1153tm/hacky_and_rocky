class RacesController < ApplicationController
  
  # GET /races
  # GET /races.json
  def index
    @races = Race.all
  end
  
  def top
    @users = User.find(:all, :order => "point DESC")
    @genres = Genre.all
    @races = Race.find(:all, :conditions => ['end_date >= ?' , Date.today.to_datetime])
    render "races/top"
  end

  # GET /races/1
  def show
    if Race.find_by_id(params[:id])
      @race = Race.find(params[:id], :include => :race_horses)
      if current_user
        @card = VotingCard.find_by(:race_id => @race.id, :user_id => current_user.id)
        flash[:notice] = "あなたの投票内容です。" if @card
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
