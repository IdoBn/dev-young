require 'spec_helper'

describe GroupsController do
	before(:each) do
		group1
		# ApplicationController.any_instance.stub(:current_user).and_return(user1)
    controller.stub(:current_user).and_return(user1)
  end

	context 'GET #index' do
		before(:each) { get :index }

		it { expect(assigns(:groups)).to eq(Group.all) }
		it { expect(response).to render_template(:index) }
	end

	[:show, :edit].each do |action|
		context "GET ##{action}" do
			before(:each) { get action, id: user1.group.id }
			
			describe 'signed in' do
				it { expect(assigns(:group)).to eq(user1.group) }
				it { expect(response).to render_template(action) }
			end

			describe 'signed out' do
			end
		end
	end
end