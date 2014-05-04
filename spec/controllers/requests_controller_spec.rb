require 'spec_helper'

describe RequestsController do
	before(:each) do
    controller.stub(:current_user).and_return(user1)
  end

  it 'takes user request to join group' do
  	expect {
  		post :request_group, group_id: group1.id
  	}.to change{ group1.unconfirmed_requests.count }.by(1)
  end

  it 'takes group request to invite user' do
  	expect {
  		group1
  		post :request_user, user_id: user3.id
  	}.to change { user3.unconfirmed_requests.count }.by(1)
  end 	
end