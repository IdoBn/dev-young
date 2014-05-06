require 'spec_helper'

describe RequestsController do
	context 'Authorized' do
	  it 'takes user request to join group' do
	  	controller.stub(:current_user).and_return(user3)
	  	expect {
	  		post :request_group, group_id: group1.id
	  	}.to change{ group1.unconfirmed_requests.count }.by(1)
	  end

	  it 'takes group request to invite user' do
	  	controller.stub(:current_user).and_return(user1)
	  	expect {
	  		group1
	  		post :request_user, user_id: user3.id
	  	}.to change { user3.unconfirmed_requests.count }.by(1)
	  end

	  context '#update' do
	  	before :each do
	  		controller.stub(:current_user).and_return(user2)
	  	end

	  	it 'adds user to group group confirm' do
	  		request = user2.new_request(group1)
	  		request.save
	  		expect {
	  			patch :update, request: { group_confirm: true }, user_id: user2.id, group_id: group1.id
	  		}.to change { group1.users.count }.by(1)
	  	end

	  	it 'adds user to group user confirm' do
	  		request = group1.new_request(user2)
	  		request.save
	  		expect {
	  			patch :update, request: { user_confirm: true }, user_id: user2.id, group_id: group1.id
	  		}.to change { group1.users.count }.by(1)
		  end
	  end
	end
	
	context	'nonAuthorized' do
		it 'takes user request to join group' do
			post :request_group, group_id: group1.id
			expect(response).to redirect_to '/'
	  end

	  it 'takes group request to invite user' do
	  	post :request_user, user_id: user3.id
	  	expect(response).to redirect_to '/'
	  end

	  it 'adds user to group group confirm' do
  		request = user2.new_request(group1)
  		request.save
  		expect {
  			patch :update, request: { group_confirm: true }, user_id: user2.id, group_id: group1.id
  		}.to_not change { group1.users.count }.by(1)
  	end

  	it 'adds user to group user confirm' do
  		request = group1.new_request(user2)
  		request.save
  		expect {
  			patch :update, request: { user_confirm: true }, user_id: user2.id, group_id: group1.id
  		}.to_not change { group1.users.count }.by(1)
	  end
	end
end