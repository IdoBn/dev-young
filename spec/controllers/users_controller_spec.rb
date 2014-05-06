require 'spec_helper'

describe UsersController do
  before :each do
    controller.stub(:current_user).and_return(user1)
  end

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'show'" do
    it "returns http success" do
      get 'show', id: user2.id
      response.should be_success
    end
  end

end
