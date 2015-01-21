require 'spec_helper'

describe "Admin Pages" do

  subject { page }

  let(:admin) { FactoryGirl.create(:admin) }

  describe "signing in a non Admin user" do
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
      sign_in admin
    end

    it 'has the right user name' do
      should have_content admin.name
      should_not have_content "Luis Ortiz"
    end

    it "has the admin menu" do
      should have_content "Admin Section" 
    end

    it "has the link in the admin menu" do
      should have_content "All Users" 
      should have_content "Notification on behalf of a student" 
    end

    it "has the Admin Calendat link" do
      should have_content "Admin Calendar", href: admin_cancellations_path
    end
  end
end
