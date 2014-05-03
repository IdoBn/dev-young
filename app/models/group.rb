class Group < ActiveRecord::Base
	has_many :users
	belongs_to :user

	validates :name, presence: true
	before_create :add_user

	private
		def add_user
			self.users << self.user
		end
end
