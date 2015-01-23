require 'spec_helper'

describe Admin::UsersController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'

      response.should be_success
    end
  end

  describe "GET 'show'" do
    xit "returns http success" do
      get 'show'
      response.should be_success
    end
  end

  describe "GET 'edit'" do
    xit "returns http success" do
      get 'edit'
      response.should be_success
    end
  end

  describe "GET 'update'" do
    xit "returns http success" do
      get 'update'
      response.should be_success
    end
  end

  describe "GET 'delete'" do
    xit "returns http success" do
      get 'destroy'
      response.should be_success
    end
  end

end
