class RequestsController < ApplicationController
	before_action :authenticate_user!
	before_action :can_request?
	before_action :load_request, only: [:update]

	def request_user
		@user = User.find(params[:user_id])
		@request = group.new_request(@user)

		respond_to do |format|
			if @request.save
				flash[:notice] = "request sent to #{@user.name}"
				format.html { redirect_to groups_path  }
				format.js
			else
				format.js { redirect_to :back, alert: "request has not been sent" }
				format.html { redirect_to groups_path, :alert => "request has not been sent" }
			end
		end
	end

	def request_group
		@group = Group.find(params[:group_id])
		@request = current_user.new_request(@group)

		respond_to do |format|
			if @request.save
				flash[:notice] = "request sent to #{@group.name}"
				format.html { redirect_to groups_path }
				format.js
			else
				format.js { redirect_to :back, alert: "request has not been sent" }
				format.html { redirect_to groups_path, :alert => "request has not been sent" }
			end
		end
	end

	def update
		if @request.update_attributes(request_params) && @request.finished?
			redirect_to group_path(@request.group.id), :notice => "#{@request.user.name} has been added to #{@request.group.name}"
		else
			redirect_to group_path(@request.group.id), :alert => "#{@request.user.name} has not been added to #{@request.group.name}"
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

		def load_request
			@request = Request.find(params[:id])
		end

		def request_params
			params.require(:request).permit(:user_confirm, :group_confirm)
		end
end