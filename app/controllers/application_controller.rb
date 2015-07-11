class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_action :set_date_if_not_set
  
  def set_date_if_not_set
    if not session[:date]
      session[:date] = Date.today.strftime("%d.%m.%Y")
    end
  end

end
