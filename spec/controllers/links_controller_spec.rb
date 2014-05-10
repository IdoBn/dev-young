require 'spec_helper'

describe LinksController do
	context 'Authorized' do
		before(:each) do 
			controller.stub(:current_user).and_return(user1)
		end

		describe 'GET #new' do
			it 'renders the new template' do
				xhr :get, :new
				expect(response).to render_template(:new)
			end
		end

		describe 'POST #create' do
			it 'creates a new link with valid attributes' do
				expect {
					xhr :post, :create, link: FactoryGirl.attributes_for(:link)
				}.to change { user1.links.count }.by(1)
			end

			it 'does not create with invalid attributes' do 
				expect {
					xhr :post, :create, link: {name: 'facebook', url: 'facebook-url'}
				}.to_not change { user1.links.count }
			end
		end

		describe 'DELETE #destroy' do
			before(:each) { @link = user1.links.create(FactoryGirl.attributes_for(:link))}
			it { expect{xhr :delete, :destroy, id: @link.id }.to change{ user1.links.count }.by(-1) }
		end
	end

	context 'nonAuthorized' do
		describe 'GET #new' do
			it 'renders the new template' do
				xhr :get, :new
				expect(response).to_not render_template(:new)
			end
		end

		describe 'POST #create' do
			it 'creates a new link with valid attributes' do
				expect {
					xhr :post, :create, link: FactoryGirl.attributes_for(:link)
				}.to_not change { user1.links.count }.by(1)
			end
		end

		describe 'DELETE #destroy' do
			before(:each) { @link = user1.links.create(FactoryGirl.attributes_for(:link))}
			it { expect{xhr :delete, :destroy, id: @link.id }.to_not change{ user1.links.count }.by(-1) }
		end
	end
end
