class Link < ActiveRecord::Base
	belongs_to :user

	validates :url, :name, presence: true
end
