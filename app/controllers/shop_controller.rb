class ShopController < ApplicationController
  autocomplete :child, :first_name, full: true,  display_value: :full_name, :extra_data => [:last_name, :number]
  autocomplete :child, :number, display_value: :number, display_value: :nice_number, :extra_data => [:number]

  
  def index
    date = Date.strptime(session[:date], "%d.%m.%Y")
    @child_consumptions = ChildConsumption.where(date: date).joins(:child)
  end
    
  def new_entry
    cc_params = params[:child_consumption] 
    other = cc_params[:other].to_f + cc_params[:fifty_cent].to_i * 0.5 + cc_params[:twenty_cent].to_i * 0.2 + cc_params[:ten_cent].to_i * 0.1 + cc_params[:five_cent].to_i * 0.05
    date = Date.strptime(session[:date], "%d.%m.%Y")
    ChildConsumption.create(child_id: cc_params[:child_id], soft_drink: cc_params[:soft_drink], other: other, time_of_day: session[:time_of_day], created_by: session[:user], date: date)
    redirect_to :shop
  end
  
  def update_entry
    @entry = ChildConsumption.find(params[:child_consumption_id])
    @entry.update(child_consumption_params)
    @entry.update(edited_by: session[:user])
    redirect_to :shop
  end
  
  def select_time_of_day
    if params[:time_of_day]
      session[:time_of_day] = params[:time_of_day]
    end
    redirect_to :shop
  end
  
  def child_data
    @child = Child.find(params[:child_id])
  end
  
  
  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def child_consumption_params
      params.require(:child_consumption).permit(:child_id, :other, :soft_drink, :fifty_cent, :twenty_cent, :ten_cent, :five_cent)
    end
end
