require 'spec_helper'

describe GroupsController do
	before(:each) {group1}

	context 'signed in' do
		before(:each) do
	    controller.stub(:current_user).and_return(user1)
	  end

		context 'GET #index' do
			before(:each) { get :index, query: 'Maria' }

			it { expect(assigns(:groups)).to eq([group1]) }
			it { expect(response).to render_template(:index) }
		end

		[:show, :edit].each do |action|
			context "GET ##{action}" do
				before(:each) { get action, id: user1.group.id }
				
				it { expect(assigns(:group)).to eq(user1.group) }
				it { expect(response).to render_template(action) }
			end
		end
	end

	context 'signed out' do
		context 'GET #index' do
			before(:each) { get :index, query: 'Maria' }

			it { expect(assigns(:groups)).to_not eq([group1]) }
			it { expect(response).to_not render_template(:index) }
		end

		[:show, :edit].each do |action|
			context "GET ##{action}" do
				before(:each) { get action, id: user1.group.id }
				
				it { expect(assigns(:group)).to_not eq(user1.group) }
				it { expect(response).to_not render_template(action) }
			end
		end
	end
end