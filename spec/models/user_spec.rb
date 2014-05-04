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
	end
end