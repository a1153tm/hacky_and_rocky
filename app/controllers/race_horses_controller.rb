class RaceHorsesController < ApplicationController
  before_action :set_race_horse, only: [:show, :edit, :update, :destroy]

  # GET /race_horses
  # GET /race_horses.json
  def index
    @race_horses = RaceHorse.all
  end

  # GET /race_horses/1
  # GET /race_horses/1.json
  def show
  end

  # GET /race_horses/new
  def new
    @race_horse = RaceHorse.new
  end

  # GET /race_horses/1/edit
  def edit
  end

  # POST /race_horses
  # POST /race_horses.json
  def create
    @race_horse = RaceHorse.new(race_horse_params)

    respond_to do |format|
      if @race_horse.save
        format.html { redirect_to @race_horse, notice: 'Race horse was successfully created.' }
        format.json { render action: 'show', status: :created, location: @race_horse }
      else
        format.html { render action: 'new' }
        format.json { render json: @race_horse.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /race_horses/1
  # PATCH/PUT /race_horses/1.json
  def update
    respond_to do |format|
      if @race_horse.update(race_horse_params)
        format.html { redirect_to @race_horse, notice: 'Race horse was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @race_horse.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /race_horses/1
  # DELETE /race_horses/1.json
  def destroy
    @race_horse.destroy
    respond_to do |format|
      format.html { redirect_to race_horses_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_race_horse
      @race_horse = RaceHorse.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def race_horse_params
      params.require(:race_horse).permit(:house_no, :comment, :race_id, :book_id)
    end
end
