class ChildrenBookkeepingController < ApplicationController
  
  def payment
    @date = Date.strptime(session[:date], "%d.%m.%Y")
    @children_account = Account.find_by_name('Kinderkasse')
    @payments = Booking.all
  end
end
