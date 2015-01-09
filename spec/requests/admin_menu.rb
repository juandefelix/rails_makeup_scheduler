require 'spec_helper'

describe "Admin Menu" do

  subject { page }
  let(:user) { FactoryGirl.create(:user)}
  let(:admin) { FactoryGirl.create(:admin)}

  describe "signing in a non admin user" do
    before do 
      sign_in
    end

    it 'has the user name' do
      should have_content "Juan Ortiz"
    end

    it { should_not have_content "Admin Section" }
  end

  describe "signing in as an admin user" do
    before do
      admin_sign_in
    end

    it 'has the user name' do
      should have_content "Juan Ortiz"
    end

    it "has the admin menu" do
      should have_content "Admin Section" 
    end

  end
end