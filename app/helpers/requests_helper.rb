module RequestsHelper
	def can_request_group?(user, group)
		if user && group
			return user.new_request(group).valid?
		else
			return false
		end
	end

	def can_request_user?(user, group)
		if user && group
			return group.new_request(user).valid?
		else
			return false
		end
	end

	def requested_group(user, group)
		if user && group
			return user.unconfirmed_requests.map(&:group).include?(group)
		else
			return false
		end
	end

	def requested_user(user, group)
		if user && group
			return group.unconfirmed_requests.map(&:user).include?(user)
		else
			return false
		end
	end
end