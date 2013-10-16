class RacesController < ApplicationController
  before_action :set_race, only: [:show, :edit, :update, :destroy]

  # GET /races
  # GET /races.json
  def index
    @races = Race.all
  end
  
  def test
    @raceTest = Race.find(1,:include => :race_horses)
  end

  # GET /races/1
  # GET /races/1.json
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_race
      @race = Race.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def race_params
      params.require(:race).permit(:name, :grad, :etype, :start_date, :end_date)
    end
end
