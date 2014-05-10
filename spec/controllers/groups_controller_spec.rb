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

		context 'PATCH #update' do
			it 'changes group attributes' do
				patch :update, id: user1.group.id,
					group: FactoryGirl.attributes_for(:group, name: 'da group')
				user1.group.reload
				user1.group.name.should eq('da group')
			end

			it 'redirects to the updated group' do
				patch :update, id: user1.group.id,
					group: FactoryGirl.attributes_for(:group)
				expect(response).to redirect_to user1.group
			end
		end

		context 'DELETE #destroy' do
			it 'should destroy the group' do
				expect {
					delete :destroy, id: group1
				}.to change{ Group.count }.by(-1)
			end
		end
	end

	context 'not owner' do
		before(:each) do
	    controller.stub(:current_user).and_return(user2)
	  end

		context 'GET #edit' do
			before(:each) { get :edit, id: user1.group.id }

			it { expect(assigns(:group)).to_not eq(user1.group) }
			it { expect(response).to_not render_template(:edit) }
		end

		context 'GET #show' do
			before(:each) { get :show, id: user1.group.id }

			it { expect(assigns(:group)).to eq(user1.group) }
			it { expect(response).to render_template(:show) }
		end

		context 'PATCH #update' do
			it 'changes group attributes' do
				patch :update, id: user1.group.id,
					group: FactoryGirl.attributes_for(:group, name: 'da group')
				user1.group.reload
				user1.group.name.should_not eq('da group')
			end

			it 'redirects to the updated group' do
				patch :update, id: user1.group.id,
					group: FactoryGirl.attributes_for(:group)
				expect(response).to redirect_to '/'
			end
		end

		context 'DELETE #destroy' do
			it 'should not destroy the group' do
				expect {
					delete :destroy, id: group1
				}.to_not change{ Group.count }.by(-1)
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

		context 'PATCH #update' do
			it 'changes group attributes' do
				patch :update, id: user1.group.id,
					group: FactoryGirl.attributes_for(:group, name: 'da group')
				user1.group.reload
				user1.group.name.should_not eq('da group')
			end

			it 'redirects to the updated group' do
				patch :update, id: user1.group.id,
					group: FactoryGirl.attributes_for(:group)
				expect(response).to redirect_to '/'
			end
		end

		context 'DELETE #destroy' do
			it 'should not destroy the group' do
				expect {
					delete :destroy, id: group1
				}.to_not change{ Group.count }.by(-1)
			end
		end
	end
end