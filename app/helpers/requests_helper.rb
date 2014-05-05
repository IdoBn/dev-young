module RequestsHelper
	def can_request_group?(current_user, group)
		current_user.new_request(group).valid?
	end

	def can_request_user?(current_user, group)
		group.new_request(current_user).valid?
	end
end