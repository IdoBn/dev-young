module RequestsHelper
	def can_request_group?(user, group)
		user.new_request(group).valid?
	end

	def can_request_user?(user, group)
		group.new_request(user).valid?
	end
end