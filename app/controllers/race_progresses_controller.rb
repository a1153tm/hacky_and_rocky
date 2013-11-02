class RaceProgressesController < ApplicationController
  
  def show
    flash[:error] = "レースが存在しません。" unless @race = Race.find_by_id(params[:id])
    #if Time.now > @race.end_date
    # @TODO　ラスト前提で現在は構成しているため。現在は日付までは追っていない 
    flash[:error] = "レース状況がありません" unless RaceProgress.find_by(:race_id => params[:id])

    # @TODO ここは予定に合わせて変更する。一応↓のコードは変な日付や文字が入っていたら、一番最後のレコードを返すようにしている。  
    #if /\d{4}-\d{2}-\d{2}/ =~ params[:date]
    #then @prog = @race.progress(DateTime.parse(params[:date]).to_date) 
    #else @prog = @race.progress(:last)
    #end
    
    unless flash[:error]
      @prog = @race.progress(:last)
    end

  end
  
end
