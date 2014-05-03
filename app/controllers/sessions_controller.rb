class SessionsController < ApplicationController
  def create
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    redirect_to root_url, notice: 'you have signed in successfully!'
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: 'you have signed out successfully!'
  end
end