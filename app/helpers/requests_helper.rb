module RequestsHelper
	def can_request_group?(user, group)
		user.new_request(group).valid?
	end

	def can_request_user?(user, group)
		group.new_request(user).valid?
	end

	def requested_group(user, group)
		user.unconfirmed_requests.map(&:group).include? group
	end

	def requested_user(user, group)
		group.unconfirmed_requests.map(&:user).include? user
	end
end