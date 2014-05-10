class User < ActiveRecord::Base
	include PgSearch

	has_many :links
	has_one :group, foreign_key: :user_id
	has_many :requests

	# validates :email, :name, :thumbnail, presence: true

	pg_search_scope :search, :against => :name,
		associated_against: {group: :name},
		:using => {
				tsearch: {:dictionary => "english"}
			}

	alias_method :old_group, :group
	def group
		return self.old_group if self.old_group
		Group.find(self.group_id) if self.group_id
	end

	def new_request(group)
		self.requests.new(group_id: group.id, user_confirm: true)
	end

	def can_request?
		self.group == nil || !self.owns?(self.group)
	end

	def unconfirmed_requests
		self.requests.where(user_confirm: false)
	end

	def create_group(params = nil)
		return false if self.group
		super
	end

	def build_group(params = nil)
		return false if self.group
		super
	end

	def owns?(obj)
		obj.user == self
	end

	def self.from_omniauth(auth)
	  where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
	    user.provider = auth.provider
	    user.uid = auth.uid
	    user.name = auth.info.name
	    user.email = auth.info.email
	    user.thumbnail = auth.info.image
	    user.oauth_token = auth.credentials.token
	    user.oauth_expires_at = Time.at(auth.credentials.expires_at)
	    user.save!
	  end
	end
	
end
