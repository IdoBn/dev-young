require 'spec_helper'

describe Group do
	context 'associations' do
		it 'adds user' do
			group = user2.build_group(group_attrs)
			group.should_receive(:add_user)
			group.save
		end

		it 'has one user' do
			expect(group1.user).to eq(user1)
		end

		it 'has many users' do
			expect { 
				group1.users << user2
			}.to change{ group1.users.count }.by(1)
		end

		it 'does not add user1 again' do
			expect { 
				group1.users << user1
			}.to_not change{ group1.users.count }
		end

		it 'still belongs to user' do
			expect {
				group1.users << user2
				group1.users << user3
			}.to_not change{ group1.user }
		end
	end
end