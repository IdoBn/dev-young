class RequestsController < ApplicationController
	before_action :can_request?

	def create
		if current_user.owns?()
			
		end
	end

	def destroy
		
	end

	private
		def can_request?
			authenticate_user!
			current_user.can_request?
		end
end