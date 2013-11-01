class RaceProgressesController < ApplicationController
  
  def show
    flash[:error] = "レースが存在しません。" unless @race = Race.find_by_id(params[:id])
    if /\d{4}-\d{2}-\d{2}/ =~ params[:date]
    then @prog = @race.progress(DateTime.parse(params[:date]).to_date) 
    else @prog = @race.progress(:last)
    end
  end
  
end