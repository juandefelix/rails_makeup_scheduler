require 'spec_helper'

describe "Facebook Authentication" do

  subject { page }
  let(:user) { FactoryGirl.create(:user) }

  describe 'before signin' do
    before { visit root_path }
    it { should_not have_content "Absence Notification" }
  end

  describe "signin" do  
    before do
      visit '/auth/facebook'
    end

    describe "a test user" do
      it { should have_content "Absence Notification" }
    end
  end
end
