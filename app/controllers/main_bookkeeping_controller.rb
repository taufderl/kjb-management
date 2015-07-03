class MainBookkeepingController < ApplicationController
  def index
    @date = Date.strptime(session[:date], "%d.%m.%Y")
    @m_account = Account.find_by_name('Lagerkasse Bar')    
    
    @bookings = Booking.where(account: @m_account)
    
    @m_account_balance = Booking.where(account: @m_account).sum(:amount)
  end

  def billing
    @m_account = Account.find_by_name('Lagerkasse Bar')
    @date = Date.strptime(session[:date], "%d.%m.%Y")
    @booking = Booking.new
    @bookings = Booking.where(date: @date, account: @m_account)
    
    @m_account_date_balance = Booking.where(["date <= ?", @date]).where(account: @m_account).sum(:amount)   
  end
  
  def count_cash
    @m_account = Account.find_by_name('Lagerkasse Bar')      
    @m_account_balance = Booking.where(account: @m_account).sum(:amount)
  end
  
  # commented out not used anymore --> see bookings_controller#new
  #def new_entry
  #  cc_params = params[:bookings] 
  #  user = User.find_by_name(session[:user])
  #  date = Date.strptime(session[:date], "%d.%m.%Y")
  #  account = Account.find_by_name('Lagerkasse Bar')
  #  accounting_number = Booking.where(account: account).count+1
  #
  #  Booking.create(account: account, created_by_ID: user, accounting_number: accounting_number, amount: cc_params[:amount], note1: cc_params[:note1], remarks: cc_params[:remarks], note2: cc_params[:note2], date: date)
  #  redirect_to :main_bookkeeping_billing
  #end
end