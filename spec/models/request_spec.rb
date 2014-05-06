require 'spec_helper'

describe Request do
	let(:group2) { user3.create_group(FactoryGirl.attributes_for(:group2)) }

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

	it 'adds user to the last group' do
		expect {
			request1 = user2.new_request(group1)
			request1.save
			request2 = user2.new_request(group2)
			request2.save
			request1.update_attribute(:group_confirm, true)
			request2.update_attribute(:group_confirm, true)
		}.to change{ user2.group }.to(group2)
	end
end
