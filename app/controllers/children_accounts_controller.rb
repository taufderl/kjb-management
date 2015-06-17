class ChildrenAccountsController < ApplicationController
  before_action :set_children_account, only: [:show, :edit, :update, :destroy]

  # GET /children_accounts
  # GET /children_accounts.json
  def index
    @children_accounts = ChildrenAccount.all
  end

  # GET /children_accounts/1
  # GET /children_accounts/1.json
  def show
  end

  # GET /children_accounts/new
  def new
    @children_account = ChildrenAccount.new
  end

  # GET /children_accounts/1/edit
  def edit
  end

  # POST /children_accounts
  # POST /children_accounts.json
  def create
    @children_account = ChildrenAccount.new(children_account_params)

    respond_to do |format|
      if @children_account.save
        format.html { redirect_to @children_account, notice: 'Children account was successfully created.' }
        format.json { render :show, status: :created, location: @children_account }
      else
        format.html { render :new }
        format.json { render json: @children_account.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /children_accounts/1
  # PATCH/PUT /children_accounts/1.json
  def update
    respond_to do |format|
      if @children_account.update(children_account_params)
        format.html { redirect_to @children_account, notice: 'Children account was successfully updated.' }
        format.json { render :show, status: :ok, location: @children_account }
      else
        format.html { render :edit }
        format.json { render json: @children_account.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /children_accounts/1
  # DELETE /children_accounts/1.json
  def destroy
    @children_account.destroy
    respond_to do |format|
      format.html { redirect_to children_accounts_url, notice: 'Children account was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_children_account
      @children_account = ChildrenAccount.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def children_account_params
      params.require(:children_account).permit(:children_id)
    end
end
