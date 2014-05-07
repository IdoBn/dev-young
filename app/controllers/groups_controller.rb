class GroupsController < ApplicationController
	before_action :authenticate_user!
	before_action :user_has_group?, only: [:new, :create]
	before_action :authorize_user!, only: [:edit, :update, :destroy]
	before_action :load_group, only: [:show, :update, :edit, :destroy, :remove_user]

	def index
		@groups = Group.search(params[:query])
		respond_to do |format|
  		format.json {render json: @groups}
  		format.html
  	end
	end

	def show
	end

	def new
		@group = current_user.build_group
	end

	def create
		@group = current_user.build_group(group_params)

		respond_to do |format|
			if @group.save
				format.html { redirect_to @group, notice: 'Group Created' }
			else
        format.html { render action: 'new' }
			end
		end
	end

	def edit
	end

	def update
		if @group.update_attributes(group_params)
			redirect_to group_path, :notice => "Group updated!"
		else
			render 'edit'
		end
	end

	def destroy
		if @group.destroy
			current_user.group_id = nil
			flash[:notice] = "Group destroyed!"
		else
			flash[:alert] = "Group was not destroyed!"
		end
		redirect_to groups_path
	end

	def remove_user
		@user = User.find(params[:user_id])
		if (current_user.owns?(@group) || @user == current_user) && @user != @group.user
			@group.users.delete(@user)
			@user.group = nil
			@user.requests.where(group_id: @group.id).first.destroy
			redirect_to group_path(@group.id), notice: "#{@user.name} has been removed from #{@group.name}"
		else
			redirect_to group_path(@group.id), alert: "You are not authorized to do this"
		end
	end

	private
		def load_group
			@group = Group.find(params[:id])
		end

		def group_params
			params.require(:group).permit(:name)
		end

		def user_has_group?
			if current_user.group
				redirect_to '/'
				flash[:alert] = "You already have a group"
			end
		end

		def authorize_user!
			unless current_user.owns?(Group.find(params[:id]))
				redirect_to '/'
				flash[:alert] = "You are not authorized to do this"
			end
		end
end