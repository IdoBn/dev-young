class GroupsController < ApplicationController
	before_action :authenticate_user!
	before_action :user_has_group?, only: [:new, :create]

	def index
		@groups = Group.all
	end

	def show 
		@group = Group.find(params[:id])
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

	private
		def group_params
			params.require(:group).permit(:name)
		end

		def user_has_group?
			if current_user.group
				redirect_to '/'
				flash[:alert] = "You already have a group"
			end
		end
end