require 'spec_helper'

describe User do
	context 'associations' do
		before :each do
			group1
		end

		it '#create_group' do
			expect(user1.create_group(group_attrs)).to eq(false)
		end

		it '#build_group' do
			expect(user1.build_group(group_attrs)).to eq(false)
		end

		it 'has one group' do
			expect(user1.group).to eq(group1)
		end

		it '#owns?' do
			expect(user1.owns?(group1)).to eq(true)
		end

		it 'has group even though it does not own it' do
			expect {
				group1.users << user2
			}.to change { user2.group }.to(group1)
		end
	end

	context 'Request' do
		it '#new_request' do
			expect {
				user3.new_request(group1).save
			}.to change { group1.unconfirmed_requests.count }.by(1)
		end
	end
end