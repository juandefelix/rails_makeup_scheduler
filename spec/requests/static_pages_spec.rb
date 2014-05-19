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
      it { should_not have_link("Available Makeups")}
      it { should_not have_link("Notify an Absence")}
    end

    describe "after signin in" do
      before { visit signin_path } 
      let(:user) { FactoryGirl.create(:user) }
      
      before do
        fill_in "Email",    with: user.email.upcase
        fill_in "Password", with: user.password
        click_button "Sign in"
      end     

      it { should_not have_link("Sign in") }
      it { should have_link("Available Makeups")}
      it { should have_link("Notify an Absence")}
    end


  end

  describe "Help Page" do
    before { visit help_path }
  
    it { should have_content('Help') }
    it { should have_title(full_title('Help')) }
  end

  describe "About" do
    before { visit about_path }

    it { should have_content('About') }
    it { should have_title(full_title('About')) }
  end
end
