class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_action :set_date_if_not_set
  before_action :ask_for_user_if_not_set
  
  def set_date_if_not_set
    if not session[:date]
      session[:date] = Date.today.strftime("%d.%m.%Y")
    end
  end
  
  def ask_for_user_if_not_set
    flash[:alert] = "Please tell me who you are before you continue! Select a user in the upper right corner."
  end

end
