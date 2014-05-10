require 'spec_helper'

describe UsersController do
  context 'Authorized' do
    before :each do
      controller.stub(:current_user).and_return(user1)
    end

    describe "GET 'index'" do
      it "returns http success" do
        get 'index'
        response.should be_success
      end

      it 'returns correct query' do
        get :index, query: 'Maria'
        expect(assigns(:users)).to eq([user1])
      end
    end

    describe "GET 'show'" do
      it "returns http success" do
        get 'show', id: user2.id
        response.should be_success
      end

      it 'returns correct user' do
        get :show, id: user1.id
        expect(assigns(:user)).to eq(user1)
      end
    end
  end

  context 'nonAuthorized' do
    describe "GET 'index'" do
      it "does not returns http success" do
        get 'index'
        response.should_not be_success
      end

      it 'does not returns correct query' do
        get :index, query: 'Maria'
        expect(assigns(:users)).to_not eq([user1])
      end
    end

    describe "GET 'show'" do
      it "does not returns http success" do
        get 'show', id: user2.id
        response.should_not be_success
      end

      it 'does not returns correct user' do
        get :show, id: user1.id
        expect(assigns(:user)).to_not eq(user1)
      end
    end
  end

end
