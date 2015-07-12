# user und date fehlt noch!!

class DisbursementsController < ApplicationController
  before_action :set_disbursement, only: [:show, :edit, :update, :destroy, :clear]

  # GET /disbursements
  # GET /disbursements.json
  def index
    @disbursements = Disbursement.all
    @dates = (Date.parse(Setting.find_by(key: :start_date).value)..Date.parse(Setting.find_by(key: :end_date).value)).to_a
    puts @dates
  end

  # GET /disbursements/1
  # GET /disbursements/1.json
  def show
  end

  # GET /disbursements/new
  def new
    @disbursement = Disbursement.new
  end

  # GET /disbursements/1/edit
  def edit
  end

  # POST /disbursements
  # POST /disbursements.json
  def create

    dparams = disbursement_params
    dparams[:user] = User.find_by_name(session[:user])
    dparams[:date] = Date.strptime(session[:date], "%d.%m.%Y")
    @disbursement = Disbursement.new(dparams)

    respond_to do |format|
      if @disbursement.save
        format.html { redirect_to :back, notice: 'Disbursement was successfully created.' }
        format.json { render :show, status: :created, location: @disbursement }
      else
        format.html { render :new }
        format.json { render json: @disbursement.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /disbursements/1
  # PATCH/PUT /disbursements/1.json
  def update
    respond_to do |format|
      if @disbursement.update(disbursement_params)
        format.html { redirect_to @disbursement, notice: 'Disbursement was successfully updated.' }
        format.json { render :show, status: :ok, location: @disbursement }
      else
        format.html { render :edit }
        format.json { render json: @disbursement.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /disbursements/1
  # DELETE /disbursements/1.json
  def destroy
    @disbursement.destroy
    respond_to do |format|
      format.html { redirect_to disbursements_url, notice: 'Disbursement was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def clear
    @disbursement.cleared = true
    @disbursement.save
    redirect_to :back
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_disbursement
      @disbursement = Disbursement.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def disbursement_params
      params.require(:disbursement).permit(:date, :account_id, :cleared, :amount, :user_id, :note)
    end
end
