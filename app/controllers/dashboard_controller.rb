class DashboardController < ApplicationController
  def index
    @disbursements = Disbursement.all
    @disbursement = Disbursement.new
  end
  
  def select_user
    if params[:user]
      session[:user] = params[:user]
    end
    redirect_to :dashboard
  end
  
  def select_date
    if params[:date]
      session[:date] = params[:date]
    end
    redirect_to :dashboard
  end
end
