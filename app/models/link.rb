class Link < ActiveRecord::Base
	belongs_to :user

	validates :url, :name, presence: true
	validates :url, :format => URI::regexp(%w(http https))
end
