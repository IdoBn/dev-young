class Group < ActiveRecord::Base
	has_many :users
	belongs_to :user, foreign_key: :user_id

	has_many :requests

	validates :name, presence: true
	validates_uniqueness_of :name
	validates_uniqueness_of :user_id

	before_create :add_user

	def new_request(user)
		self.requests.create(user_id: user.id, group_confirm: true)
	end

	def unconfirmed_requests
		self.requests.where(group_confirm: false)
	end

	private
		def add_user
			self.users << self.user
		end
end
