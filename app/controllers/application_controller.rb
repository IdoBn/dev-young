class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def toast(type, text)
  	flash[:toastr] = { type => text }
	end

  private
		def current_user
		  @current_user ||= User.find(session[:user_id]) if session[:user_id]
		end
		helper_method :current_user

		def authenticate_user!
			unless current_user
				redirect_to '/'
				flash[:alert] = "You must be logged in"
			end
		end
end
