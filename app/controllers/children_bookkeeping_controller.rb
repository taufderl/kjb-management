class ChildrenBookkeepingController < ApplicationController
  
  def payment
    @date = Date.strptime(session[:date], "%d.%m.%Y")
    @children_account = Account.find_by_name('Kinderkasse')
    @payments = Booking.where("note1 = ?", "Ein-/Auszahlung").where("note2 like ?", "%Kinderkasse%")
  end
  
  def transfer
    @m_account = Account.find_by_name('Lagerkasse Bar')      
    @m_account_balance = Booking.where(account: @m_account).sum(:amount)
    
    @c_account = Account.find_by_name('Kinderkasse')
    @c_account_balance = Booking.where(account: @c_account).sum(:amount)
    
    @m_c_account_sum = @m_account_balance + @c_account_balance
  end
  
end
