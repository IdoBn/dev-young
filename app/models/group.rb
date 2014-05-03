class Group < ActiveRecord::Base
	has_many :users
	belongs_to :user

	validates :name, presence: true
end
