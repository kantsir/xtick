class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :authenticate_user!


  def staff_active?
    result = false
    return result if current_user.nil?
    result = current_user.staff.active if  current_user.staff.present?
    result
  end

end
