class RequestsController < ApplicationController
	before_action :authenticate_user!
	before_action :can_request?
	# before_action :load_group, only: [:request_user]

	def request_user
		@user = User.find(params[:user_id])
		@request = group.new_request(@user)

		respond_to do |format|
			if @request.save
				format.html { redirect_to groups_path, :notice => "request sent to #{@user.name}" }
				format.js
			else
				render :error
			end
		end
	end

	def request_group
		@group = Group.find(params[:group_id])
		@request = current_user.new_request(@group)

		respond_to do |format|
			if @request.save
				format.html { redirect_to groups_path, :notice => "request sent to #{@group.name}" }
				format.js
			else
				render :error
			end
		end
	end

	private
		def can_request?
			current_user.can_request?
		end

		def group
			if current_user.owns?(current_user.group)
				return current_user.group
			end 
		end
end