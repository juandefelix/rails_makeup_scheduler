require 'spec_helper'

describe "Business" do
  subject { page }

  describe "sign in page has a link to busness creation" do
    before { visit new_user_session_path }
    it { should have_link('Sign up your business', href: new_business_path) }    
  end

  describe "Signing up a business creates a new business in database" do
    before do
      visit new_business_path
      fill_in :name,  with: "test business"
      fill_in "slug",  with: "test_business"
      fill_in "email", with: "test@business.com"
      fill_in "address", with: "1230 W marine drive"
      fill_in "city", with: "test city"
      fill_in "zip", with: "40210"
      fill_in "website", with: "www.test_school.com"
    end

    it do 
      expect{ click_button "Create business" }.to change{ Business.count }.by 1
    end
  end
end
