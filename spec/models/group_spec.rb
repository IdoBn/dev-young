require 'spec_helper'

describe Group do
	it 'has many users' do
		expect {
			group1.users << user2
		}.to change { group1.users.count }.by(1)
	end

	it 'adds user' do
		group = user2.build_group(group_attrs)
		group.should_receive(:add_user)
		group.save
	end
end