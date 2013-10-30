class RaceProgressesController < ApplicationController
  def show
    flash[:error] = "レースが存在しません。" unless @race = Race.find(params[:id])
    @prog = @race.progress(:last)
  end
end
