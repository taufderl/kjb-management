class DashboardController < ApplicationController
  def index
    @disbursements = Disbursement.where(cleared: false)
    @disbursement = Disbursement.new
    @news = News.new
    @latest_news = News.last(5).reverse
    
    @date = Date.strptime(session[:date], "%d.%m.%Y").to_formatted_s(:short)
    
    # Versuch 1
    # @birthday_child = Array.new
    # @birthday_child.insert(Child.where{Date.strptime(birthday.strftime("%F"),"%Y-%m-%d").to_formatted_s(:short).eql? @date})
    
    # Versuch 2
    #@recent_month = Date.strptime(session[:date], "%d.%m.%Y").mon
    #@recent_day = Date.strptime(session[:date], "%d.%m.%Y").mday
    #@children = Child.all
    #@birthday_child = Array.new
    
    #for element in @children do
    #  if (element.birthday.mon == @recent_month && element.birthday.mday == @recent_day)
    #    @birthday_child.insert(element)
    #  end
    #end
    @dates = Date.today..Date.today+10.days
    @birthdays = {}
    @dates.each do |date|
      children = Child.where(birthday: date)
      if children.any?
        @birthdays[date] = children
      end
    end
  end
  
  def select_user
    if params[:user]
      session[:user] = params[:user]
    end
    redirect_to :back
  end
  
  def select_date
    if params[:date]
      session[:date] = params[:date]
    end
    redirect_to :back
  end
end
