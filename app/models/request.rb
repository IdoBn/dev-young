class Request < ActiveRecord::Base
	belongs_to :user
	belongs_to :group

	validates_uniqueness_of :user_id, :scope => :group_id
	validate :user_can_request
	# before_save :user_can_request

	private
		def user_can_request
			@user = self.user
			if @user
				errors.add :user, 'user cannot own a group' unless @user.can_request?
			end
		end
end
