require 'spec_helper'

describe "Static Pages" do

  subject { page }

  describe "Home Page" do
    before { visit root_path }

    it { should have_content('Makeup Scheduler')}
    it { should have_title(full_title('')) }
    it { should_not have_title("| Home") }

    describe "without signing in" do
      it { should have_link("Sign in") }
    end

    describe "after signin in" do
      let(:user) { FactoryGirl.create(:user) }
      
      before do
        sign_in
      end     

      it { should_not have_link("Sign in") }
      it { should have_link("Available Makeups")}
      it { should have_link("Absence Notification")}
    end
  end

  describe "Help Page" do
    before { visit help_path }
  
    xit { should have_content('Help') }
    xit { should have_title(full_title('Help')) }
  end

  describe "Contact" do
    before { visit contact_path }

    it { should have_content('Contact') }
    it { should have_title(full_title('Contact')) }
  end
end
