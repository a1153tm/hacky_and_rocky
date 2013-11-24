class AdminController < ApplicationController
  before_action :set_breadcrumb 
  before_action :set_race, only: [:update_race, :destroy_race]

  def login
  end

  def home
  end

  def list_race
    add_breadcrumb 'レース検索・編集', adm_race_path
    @races = Race.paginate page: params[:page], order: 'start_date desc', per_page: 10
    render 'race_list'
  end

  def new_race
    add_breadcrumb 'レース登録', new_race_path
    @race = Race.new
    @genres = Genre.find(:all)
    @books = Book.find(:all)
  end

  def create_race
    @race = Race.new(race_params)
    params[:race_horses].each_with_index do |(i,v)|
      horse = RaceHorse.new(horse_no: i.to_i + 1, book_id: v, comment: params[:race_horse_comments][i],
        odds: params[:race_horse_odds][i])
      logger.debug horse
      horse.race = @race
      @race.race_horses << horse
    end
    @race.save!
    redirect_to adm_race_path
  end

  def edit_race
    add_breadcrumb 'レース編集', adm_race_path
    @race = Race.find(params[:id])
    @genres = Genre.find(:all)
    @books = Book.find(:all)
  end

  def update_race
    Race.transaction do
      # 出走馬を再作成する
      #@race.race_horses.each {|h| h.destroy}
      params[:race_horses].each_with_index do |(i,v)|
        #horse = RaceHorse.new(horse_no: i.to_i + 1, book_id: v, comment: params[:race_horse_comments][i],
        #  odds: params[:race_horse_odds][i])
        #horse.race = @race
        horse = @race.race_horses[i.to_i]
        horse.update_attributes(horse_no: i.to_i + 1, book_id: v, comment: params[:race_horse_comments][i],
          odds: params[:race_horse_odds][i])
        horse.save
      end
      # レースのベースを更新する
      @race.update(race_params)
    end
    redirect_to adm_race_path
  end

  def destroy_race
    @race.destroy
    redirect_to adm_race_path
  end

  private
    def set_race
      @race = Race.find(params[:id])
    end

    def race_params
      params.require(:race).permit(:name, :genre_id, :etype, :grade, :collect_start, :collect_end, :start_date, :end_date)
    end

    def set_breadcrumb
      add_breadcrumb 'Home', admin_home_path
    end
end

