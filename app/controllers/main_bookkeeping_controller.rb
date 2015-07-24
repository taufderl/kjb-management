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
    
    @m_account_balance = Booking.where(account: @m_account).sum(:amount)
    @m_account_date_balance = Booking.where(["date = ?", @date]).where(account: @m_account).where("note1 != ?", "Ein-/Auszahlung").sum(:amount)   
  end
  
  def count_cash
    @m_account = Account.find_by_name('Lagerkasse Bar')      
    @m_account_balance = Booking.where(account: @m_account).sum(:amount)
    @count = session[:main_account_cash] || {}
  end
    
  def save_cash
    session[:main_account_cash] = params[:count]
    render text: "OK"
  end
  
  def export
    account = Account.find_by_name('Lagerkasse Bar')
    @csv = Booking.to_csv({account: account}, {})
    send_data @csv, filename: "Lagerkasse_Export_#{Time.now.strftime("%Y-%m-%d_%H-%M-%S")}.csv"
  end
  
end