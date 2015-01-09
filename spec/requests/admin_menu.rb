require 'spec_helper'

describe "Admin Menu" do

  subject { page }

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

    it 'has the right user name' do
      should have_content "Juan Ortiz"
      should_not have_content "Luis Ortiz"
    end

    it "has the admin menu" do
      should have_content "Admin Section" 
    end

    it "has the link in the admin menu" do
      should have_content "All Users" 
      should have_content "Notification on behalf of a student" 
      should have_content "Admin Calendar" 
    end
  end
end
