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
	end
end