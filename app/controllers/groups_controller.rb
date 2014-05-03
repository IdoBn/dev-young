class GroupsController < ApplicationController
	before_action :authenticate_user!

	def index
		@groups = Group.all
	end

	def show 
		@group = Group.find(params[:id])
	end

	def new
		@group = Group.new
	end

	def create
		@group = Group.new(group_params)

		respond_to do |format|
			if @group.save
				@group.user = current_user
				@group.users << current_user
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
end