class RequestsController < ApplicationController
	before_action :can_request?
	before_action :load_group, only: [:request_user]

	def request_user
		@user = User.find(params[:user_id])
		@group.create_request(@user)
		redirect_to groups_path
	end

	def request_group
		@group = Group.find(params[:group_id])
		current_user.create_request(@group)
		redirect_to groups_path
	end

	private
		def can_request?
			authenticate_user!
			current_user.can_request?
		end

		def load_group
			if current_user.owns?(current_user.group)
				@group = current_user.group
			end 
		end
end