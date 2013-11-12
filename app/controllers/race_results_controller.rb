class RaceResultsController < ApplicationController

  # GET /race/1/result
  # GET /race/1/result.json
  def show
    race = Race.find(params[:id])
    @result = race.race_result()
    if current_user
      @card = VotingCard.find_by(race_id: race.id, user_id: current_user.id)
    end
  end

end
