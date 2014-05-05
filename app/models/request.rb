class Request < ActiveRecord::Base
	belongs_to :user
	belongs_to :group

	validates_uniqueness_of :user_id, :scope => :group_id
	validate :user_can_request
	
	after_save :check_confirm

	private
		def user_can_request
			@user = self.user
			if @user
				errors.add :user, 'user cannot own a group' unless @user.can_request?
			end
		end

		def check_confirm
			if self.group_confirm && self.user_confirm
				self.group.users << self.user
			end
		end
end
