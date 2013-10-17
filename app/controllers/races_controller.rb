#
# Description aw
# Author Sniker.
# created 2013/10/7
#

class RacesController < ApplicationController
  before_action :set_race, only: [:edit, :update, :destroy]

  # GET /races
  # GET /races.json
  def index
    @races = Race.all
  end
  
  def test
    @raceTest = Race.find(1,:include => :race_horses)
  end
  
  # GET /races/1
  def show
    @race = nil
    @error = nil
    @horseNumberColors = ['white','black','red','blue','orange','green','pink','skyblue','yellow','limegreen']

    if Race.find_by_id(params[:id]) != nil
      #if @current_user
      #  redirect_to :action => 'index'
      #end
      @race = Race.find(params[:id],:include => :race_horses)
    else 
      redirect_to :action => 'index'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_race
      @race = Race.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def race_params
      params.require(:race).permit(:name, :grade, :etype, :start_date, :end_date)
    end
end
