require 'spec_helper'

describe "User pages" do
  
  subject { page }

  describe "siging up with facebook creates a User" do
    before { visit root_path }
    it do
      expect { find(:xpath, "//a[@href='/auth/facebook']").click }.to change(User, :count)
    end
  end

  describe "profile page" do

    # let(:user) { FactoryGirl.create(:user) }

    before do 
      sign_in
      @user = User.first
      visit user_path @user
    end

    it { should have_title full_title @user.name }
    it { should have_content @user.name }
  end

  describe "signup page" do #no signup page since Facebook sign in
    before { visit new_user_registration_path }

    it { should have_content "Sign up"}
    it { should have_title(full_title("User Registration")) }
  end

  describe "signup" do

    before { visit new_user_registration_path }

    let(:submit) { "Sign up" }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end

      describe "after submission" do
        before { click_button submit }

        it { should have_title(full_title("User Registration")) }
        it { should have_content('error') }
      end  

    end

    describe "with valid information" do
      before do
        fill_in "Name",  with: "Example User"
        fill_in "Email", with: "user@example.com"
        fill_in "Password", with: "foobar"
        fill_in "Password Confirmation", with: "foobar"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end

      describe "after saving the user" do
        before { click_button submit }
        let(:user) { User.find_by(email: 'user@example.com') }

        it { should have_link('Logout') }
        it { should have_title(full_title) }
        it { should have_content('Welcome') }
      end
    end
  end
end