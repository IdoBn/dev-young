class UsersController < ApplicationController
	before_action :authenticate_user!
	
  def index
  	@users = User.search(params[:query])
  	respond_to do |format|
  		format.json {render json: @users, only: [:name, :id]}
  		format.html
  	end
  end

  def show
  	@user = User.find(params[:id])
  end
end
