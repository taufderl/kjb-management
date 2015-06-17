class MainAccountsController < ApplicationController
  before_action :set_main_account, only: [:show, :edit, :update, :destroy]

  # GET /main_accounts
  # GET /main_accounts.json
  def index
    @main_accounts = MainAccount.all
  end

  # GET /main_accounts/1
  # GET /main_accounts/1.json
  def show
  end

  # GET /main_accounts/new
  def new
    @main_account = MainAccount.new
  end

  # GET /main_accounts/1/edit
  def edit
  end

  # POST /main_accounts
  # POST /main_accounts.json
  def create
    @main_account = MainAccount.new(main_account_params)

    respond_to do |format|
      if @main_account.save
        format.html { redirect_to @main_account, notice: 'Main account was successfully created.' }
        format.json { render :show, status: :created, location: @main_account }
      else
        format.html { render :new }
        format.json { render json: @main_account.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /main_accounts/1
  # PATCH/PUT /main_accounts/1.json
  def update
    respond_to do |format|
      if @main_account.update(main_account_params)
        format.html { redirect_to @main_account, notice: 'Main account was successfully updated.' }
        format.json { render :show, status: :ok, location: @main_account }
      else
        format.html { render :edit }
        format.json { render json: @main_account.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /main_accounts/1
  # DELETE /main_accounts/1.json
  def destroy
    @main_account.destroy
    respond_to do |format|
      format.html { redirect_to main_accounts_url, notice: 'Main account was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_main_account
      @main_account = MainAccount.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def main_account_params
      params[:main_account]
    end
end
