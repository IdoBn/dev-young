class User < ActiveRecord::Base
	has_one :group

	def create_group(params)
		return false if self.group
		super
	end

	def build_group(params)
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
