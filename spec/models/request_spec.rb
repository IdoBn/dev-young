require 'spec_helper'

describe Request do
	it 'adds user to group when group confirms' do
		expect{
			request = user2.new_request(group1)
			request.save
			request.update_attribute(:group_confirm, true)
		}.to change{ group1.users.count }.by(1)
	end

	it 'adds user to group when user confirms' do
		expect {
			request = group1.new_request(user2)
			request.save
			request.update_attributes(user_confirm: true)
		}.to change{ group1.users.count }.by(1)
	end
end
