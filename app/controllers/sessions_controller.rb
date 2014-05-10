class SessionsController < ApplicationController
  def create
  	not_new_user =  User.where(env['omniauth.auth'].slice(:provider, :uid)).first
    user = User.from_omniauth(env["omniauth.auth"])
    UserMailer.registration(user).deliver unless not_new_user
    session[:user_id] = user.id 
    redirect_to root_url, notice: 'you have signed in successfully!'
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: 'you have signed out successfully!'
  end
end