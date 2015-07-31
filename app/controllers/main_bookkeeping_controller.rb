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
    @bookings = Booking.where(date: @date, account: @m_account).where("note1 != ?", "Ein-/Auszahlung")
    @scouts = Scout.all
    @scout_accounts = ScoutAccount.all
    
    @accounting_number = Booking.where(account_id: @m_account).map {|b| b.accounting_number}.compact.max.to_i+1
    @user = User.find_by_name(session[:user])
    
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
  
  def daily_closing
    @date = Date.strptime(session[:date], "%d.%m.%Y")
    @m_account = Account.find_by_name('Lagerkasse Bar')      
    @m_account_balance = Booking.where(account: @m_account).sum(:amount)
    
    @c_account = Account.find_by_name('Kinderkasse')
    @c_account_balance = Booking.where(account: @c_account).sum(:amount)
    
    @m_c_account_sum = @m_account_balance + @c_account_balance
    
    @m_account_date_balance = Booking.where(["date = ?", @date]).where(account: @m_account).where("note1 != ?", "Ein-/Auszahlung").sum(:amount)   
    @m_account_date_disbursement = Disbursement.where(["date = ?", @date]).where(account: @m_account).where(cleared: false).sum(:amount)
    @m_account_date_drawback = @m_account_date_disbursement + @m_account_date_balance
    
    @m_account_date_disbursements = Disbursement.where(["date = ?", @date]).where(account: @m_account)

   
    @count = session[:main_account_cash] || {}
  end
  
  def clear_disbursement
    @date = Date.strptime(session[:date], "%d.%m.%Y")
    @m_account = Account.find_by_name('Lagerkasse Bar')    
    @m_account_date_disbursements = Disbursement.where(["date = ?", @date]).where(account: @m_account)
    
    @m_account_date_disbursements.each do |e| 
      e.update('cleared' => true)
    end
    
    respond_to do |format|
      format.html{ redirect_to main_bookkeeping_daily_closing_path, notice: 'Ausgelegtes Geld als erledigt markiert.'} 
    end 
  end
  
end

