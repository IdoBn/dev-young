class RequestsController < ApplicationController
	before_action :authenticate_user!
	before_action :can_request?
	before_action :load_request, only: [:update, :destroy]
	before_action :authorize_user!, only: [:update, :destroy]

	def request_user
		@user = User.find(params[:user_id])
		@request = group.new_request(@user)

		respond_to do |format|
			if @request.save
				RequestMailer.delay.user_request(@request)
				format.html { redirect_to groups_path  }
				format.js
			else
				format.js { redirect_to group_path(@request.group_id), alert: "request has not been sent" }
				format.html { redirect_to groups_path, :alert => "request has not been sent" }
			end
		end
	end

	def request_group
		@group = Group.find(params[:group_id])
		@request = current_user.new_request(@group)

		respond_to do |format|
			if @request.save
				RequestMailer.delay.group_request(@request)
				format.html { redirect_to groups_path, notice: "request has been sent" }
				format.js
			else
				format.js { redirect_to group_path(@request.group_id), alert: "request has not been sent" }
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

	def destroy
		if @request.destroy
			redirect_to group_path(@request.group.id), notice: "Request was destroyed!"
		else
			redirect_to group_path(@request.group.id), alert: "Request was not destroyed!"
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
			@request = Request.where(user_id: params[:user_id], group_id: params[:group_id]).first
		end

		def request_params
			params.require(:request).permit(:user_confirm, :group_confirm)
		end

		def authorize_user!
			begin
				unless current_user.owns?(@request.group) || current_user.owns?(@request)
					redirect_to '/'
					flash[:alert] = "You are not authorized to do this"
				end
			rescue
				redirect_to '/'
				flash[:alert] = "You are not authorized to do this"
			end
		end
end