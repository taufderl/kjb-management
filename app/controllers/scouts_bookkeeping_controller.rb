class ScoutsBookkeepingController < ApplicationController
  autocomplete :scout, :first_name, full: true,  :extra_data => [:last_name]
  
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
      
    @bookings_cash = Booking.where(account: @s_account_cash, date: @date).where("note1 != ?", "Ein-/Auszahlung")
    @bookings_giro = Booking.where(account: @s_account_giro, date: @date).where("note1 != ?", "Ein-/Auszahlung")    
    
    @s_account_cash_balance = Booking.where(account: @s_account_cash).sum(:amount)
    @s_account_giro_balance = Booking.where(account: @s_account_giro).sum(:amount)    
    
    @s_account_cash_date_balance = Booking.where(["date = ?", @date]).where(account: @s_account_cash).where("note1 != ?", "Ein-/Auszahlung").sum(:amount)
    @s_account_giro_date_balance = Booking.where(["date = ?", @date]).where(account: @s_account_giro).where("note1 != ?", "Ein-/Auszahlung").sum(:amount)    
    
    @scout_accounts = ScoutAccount.all
    
    @booking = Booking.new
  end
  
  def payment
    @scouts = Scout.all
    @date = Date.strptime(session[:date], "%d.%m.%Y")
    @s_account_cash = Account.find_by_name('Gruppenleiterkasse')
    @s_account_giro = Account.find_by_name('Gruppenleiterkasse Girokonto')
    @payments = Booking.where("note1 = ?", "Ein-/Auszahlung").where("note2 like ?", "%Gruppenleiter%")
    # ggf. unter payments noch jeweils den zweiten Buchungssatz hinzufuegen
  end
  
  def count_cash
    @s_account_cash = Account.find_by_name('Gruppenleiterkasse')      
    @s_account_cash_balance = Booking.where(account: @s_account_cash).sum(:amount)
    @count = session[:scouts_account_cash] || {}
  end
    
  def save_cash
    session[:scouts_account_cash] = params[:count]
    render text: "OK"
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
  
  def export
    account_cash = Account.find_by_name('Gruppenleiterkasse')
    account_giro = Account.find_by_name('Gruppenleiterkasse Girokonto')
    @csv = Booking.to_csv({account: [account_cash, account_giro]}, {})
    send_data @csv, filename: "Gruppenleiterkasse_Export_#{Time.now.strftime("%Y-%m-%d_%H-%M-%S")}.csv"
  end
  
  def daily_closing
    @date = Date.strptime(session[:date], "%d.%m.%Y")
    @s_account = Account.find_by_name('Gruppenleiterkasse')      
    @s_account_balance = Booking.where(account: @s_account).sum(:amount)
    
    @s_account_date_balance = Booking.where(["date = ?", @date]).where(account: @s_account).where("note1 != ?", "Ein-/Auszahlung").sum(:amount)   
    @s_account_date_disbursements = Disbursement.where(["date = ?", @date]).where(account: @s_account).where(cleared: false).sum(:amount)
    @s_account_date_drawback = @s_account_date_disbursements + @s_account_date_balance
    
    @count = session[:main_account_cash] || {}
  end
  
  def clear_disbursement
    @date = Date.strptime(session[:date], "%d.%m.%Y")
    @s_account = Account.find_by_name('Gruppenleiterkasse')    
    @s_account_date_disbursements = Disbursement.where(["date = ?", @date]).where(account: @s_account)
    
    @s_account_date_disbursements.each do |e| 
      e.update('cleared' => true)
    end
    
    respond_to do |format|
      format.html{ redirect_to scouts_bookkeeping_daily_closing_path, notice: 'Ausgelegtes Geld als erledigt markiert.'} 
    end 
  end
  
  def stats
    @consumption = ScoutConsumption.all
    @count_beer = ScoutConsumption.all.sum(:beer)
    @count_sausage = ScoutConsumption.all.sum(:sausage)
    @count_pork = ScoutConsumption.all.sum(:pork)
    @count_turkey = ScoutConsumption.all.sum(:turkey)
    @count_corn = ScoutConsumption.all.sum(:corn)
    
    @count_scouts_softdrink = ScoutConsumption.all.sum(:soft_drink)
    @count_children_softdrink = ChildConsumption.all.sum(:soft_drink)
    @count_softdrink = @count_scouts_softdrink + @count_children_softdrink
    
    @count_beer_crate = (@count_beer.to_d/24)
    @count_softdrink_crate = (@count_softdrink.to_d/24)
    
    @scouts = Scout.all
    # @scout_beer = @scouts.max_by{|a| a.beer_consumption}    
  end
  
  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def good_params
      params.permit(:scout_id, :scout_consumption_id)
    end
    
    def scout_consumption_params
      params.require(:scout_consumption).permit(:beer, :pork, :sausage, :soft_drink, :turkey, :corn, :other)
    end
end
