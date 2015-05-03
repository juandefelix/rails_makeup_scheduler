require 'spec_helper'

describe "User pages" do
  
  subject { page }

  describe "siging up with facebook creates a User" do
    before { visit new_user_registration_path }
    it do
      expect { find(:xpath, "//a[@href='/auth/facebook']").click }.to change(User, :count)
    end
  end

  describe "profile page" do
    before do 
      facebook_sign_in
      @user = User.first
      visit user_path @user
    end

    it { should have_title full_title @user.name }
    it { should have_content @user.name }
  end

  describe "signup page" do 
    before { visit new_user_registration_path }

    it { should have_content "Sign up"}
    it { should have_title(full_title("User Registration")) }
  end

  describe "signup" do

    before { visit new_user_registration_path }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button 'Sign up' }.not_to change(User, :count)
      end

      describe "after submission" do
        before { click_button 'Sign up' }

        it { should have_title(full_title("User Registration")) }
        it { should have_content('error') }
      end  

    end

    describe "with valid information" do
      before do
        fill_in "user_name", with: "user name"
        fill_in "user_email", with: "user@example.com"
        fill_in "Password", with: "foobar12"
        fill_in "Password Confirmation", with: "foobar12"
      end

      it "should create a user" do
        expect { click_button 'Sign up' }.to change(User, :count).by(1)
      end

      describe "after saving the user" do
        before { click_button 'Sign up' }

        it { should have_link('Logout') }
        it { should have_title(full_title) }
        it { should have_content('Absence Notification') }
      end
    end
  end
end