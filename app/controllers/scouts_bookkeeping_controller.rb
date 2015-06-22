class ScoutsBookkeepingController < ApplicationController
  def index
    @scouts = Scout.all
    @dates = (Date.parse(Setting.find_by(key: :start_date).value)..Date.parse(Setting.find_by(key: :end_date).value)).to_a
    puts @dates
    @consumption = {}
    @dates.each do |date|
      @consumption[date] = ScoutConsumption.where(date: date).each.map { |sc| sc.total }.sum
    end
    @balance = {}
    @balance[ @dates.first ] = 0
    @dates.take(@dates.length-1).each_with_index.map {|e,i| [e, @dates[i+1]]}.each do |beforedate, date|  
      @balance[date] = @balance[beforedate] - @consumption[date]
    end
  end
  
  def index2
    date = Date.strptime(session[:date], "%d.%m.%Y")
    s_account_cash = Account.find_by_name('Gruppenleiterkasse')
    s_account_giro = Account.find_by_name('Gruppenleiterkasse Girokonto')        
    
    @bookings_cash = Booking.where(account: s_account_cash)
    @bookings_giro = Booking.where(account: s_account_giro)
    
    @s_account_cash_balance = Booking.where(account: s_account_cash).sum(:amount)
    @s_account_giro_balance = Booking.where(account: s_account_giro).sum(:amount)
    
  end

    def billing

    @date = Date.strptime(session[:date], "%d.%m.%Y")
    @s_account_cash = Account.find_by_name('Gruppenleiterkasse')
    @s_account_giro = Account.find_by_name('Gruppenleiterkasse Girokonto')       
      
    @bookings_cash = Booking.where(account: @s_account_cash, date: @date)
    @bookings_giro = Booking.where(account: @s_account_giro, date: @date)    
    
    @s_account_cash_date_balance = Booking.where(["date <= ?", @date]).where(account: @s_account_cash).sum(:amount)
    @s_account_giro_date_balance = Booking.where(["date <= ?", @date]).where(account: @s_account_giro).sum(:amount)    
    
    @booking = Booking.new
    @bookings = Booking.where(date: @date, account: @account)    
  end

  def input
    date = Date.strptime(session[:date], "%d.%m.%Y")
    @scout_consumptions = ScoutConsumption.where(date: date).joins(:scout)
    @scouts = Scout.all - @scout_consumptions.map {|sc| sc.scout}
  end
  
  def new_entry
    date = Date.strptime(session[:date], "%d.%m.%Y")
    scout = Scout.find(params[:scout_id])
    ScoutConsumption.create(scout: scout, date: date, created_by: session[:user])
    redirect_to :scouts_bookkeeping_input
  end
  
  def update_entry
    puts params
    @entry = ScoutConsumption.find(params[:scout_consumption_id])
    @entry.update(scout_consumption_params)
    @entry.update(edited_by: session[:user])
    redirect_to :scouts_bookkeeping_input
  end
  
  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def good_params
      params.permit(:scout_id, :scout_consumption_id)
    end
    
    def scout_consumption_params
      params.require(:scout_consumption).permit(:beer, :pork, :sausage, :soft_drink, :turkey, :other)
    end
end
