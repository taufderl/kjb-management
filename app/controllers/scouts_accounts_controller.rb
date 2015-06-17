class ScoutsAccountsController < ApplicationController
  before_action :set_scouts_account, only: [:show, :edit, :update, :destroy]

  # GET /scouts_accounts
  # GET /scouts_accounts.json
  def index
    @scouts_accounts = ScoutsAccount.all
  end

  # GET /scouts_accounts/1
  # GET /scouts_accounts/1.json
  def show
  end

  # GET /scouts_accounts/new
  def new
    @scouts_account = ScoutsAccount.new
  end

  # GET /scouts_accounts/1/edit
  def edit
  end

  # POST /scouts_accounts
  # POST /scouts_accounts.json
  def create
    @scouts_account = ScoutsAccount.new(scouts_account_params)

    respond_to do |format|
      if @scouts_account.save
        format.html { redirect_to @scouts_account, notice: 'Scouts account was successfully created.' }
        format.json { render :show, status: :created, location: @scouts_account }
      else
        format.html { render :new }
        format.json { render json: @scouts_account.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /scouts_accounts/1
  # PATCH/PUT /scouts_accounts/1.json
  def update
    respond_to do |format|
      if @scouts_account.update(scouts_account_params)
        format.html { redirect_to @scouts_account, notice: 'Scouts account was successfully updated.' }
        format.json { render :show, status: :ok, location: @scouts_account }
      else
        format.html { render :edit }
        format.json { render json: @scouts_account.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /scouts_accounts/1
  # DELETE /scouts_accounts/1.json
  def destroy
    @scouts_account.destroy
    respond_to do |format|
      format.html { redirect_to scouts_accounts_url, notice: 'Scouts account was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_scouts_account
      @scouts_account = ScoutsAccount.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def scouts_account_params
      params.require(:scouts_account).permit(:scouts_id)
    end
end
