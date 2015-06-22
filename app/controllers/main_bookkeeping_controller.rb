class MainBookkeepingController < ApplicationController
  def index
    date = Date.strptime(session[:date], "%d.%m.%Y")
    account = Account.find_by_name('Lagerkasse Bar')    
    
    @bookings = Booking.where(account: account)
  end

  def billing
    date = Date.strptime(session[:date], "%d.%m.%Y")
    account = Account.find_by_name('Lagerkasse Bar')
    @booking = Booking.where(date: date, account: account)
  end
    
  def new_entry
    cc_params = params[:bookings] 
    user = User.find_by_name(session[:user])
    date = Date.strptime(session[:date], "%d.%m.%Y")
    account = Account.find_by_name('Lagerkasse Bar')
    
    Booking.create(account: account, created_by_ID: user, amount: cc_params[:amount], note1: cc_params[:note1], remarks: cc_params[:remarks], note2: cc_params[:note2], date: date)
    redirect_to :main_bookkeeping_billing
  end
  
end