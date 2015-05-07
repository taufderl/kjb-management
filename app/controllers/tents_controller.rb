class TentsController < ApplicationController
  before_action :set_tent, only: [:show, :edit, :update, :destroy]

  # GET /tents
  # GET /tents.json
  def index
    @tents = Tent.all
  end

  # GET /tents/1
  # GET /tents/1.json
  def show
  end

  # GET /tents/new
  def new
    @tent = Tent.new
  end

  # GET /tents/1/edit
  def edit
  end

  # POST /tents
  # POST /tents.json
  def create
    @tent = Tent.new(tent_params)

    respond_to do |format|
      if @tent.save
        format.html { redirect_to @tent, notice: 'Tent was successfully created.' }
        format.json { render :show, status: :created, location: @tent }
      else
        format.html { render :new }
        format.json { render json: @tent.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tents/1
  # PATCH/PUT /tents/1.json
  def update
    respond_to do |format|
      if @tent.update(tent_params)
        format.html { redirect_to @tent, notice: 'Tent was successfully updated.' }
        format.json { render :show, status: :ok, location: @tent }
      else
        format.html { render :edit }
        format.json { render json: @tent.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tents/1
  # DELETE /tents/1.json
  def destroy
    @tent.destroy
    respond_to do |format|
      format.html { redirect_to tents_url, notice: 'Tent was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tent
      @tent = Tent.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tent_params
      params.require(:tent).permit(:number)
    end
end
