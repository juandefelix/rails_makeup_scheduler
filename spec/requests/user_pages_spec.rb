require 'spec_helper'

describe "User pages" do
  
  subject { page }

  describe "siging up with facebook creates a User" do
    before { visit root_path }
    it do
      expect { click_link "Sign in" }.to change(User, :count)
    end
  end

  describe "profile page" do

    # let(:user) { FactoryGirl.create(:user) }

    before do 
      sign_in
      visit user_path @user
    end

    it { should have_title full_title @user.name }
    it { should have_content @user.name }
  end

  describe "signup page" do
    before { visit signup_path }

    xit { should have_content "Sign up"}
    xit { should have_title(full_title("Sign up")) }
  end

  describe "signup" do

    before { visit signup_path }

    let(:submit) { "Create my account" }

    describe "with invalid information" do
      xit "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end

      describe "after submission" do
        before { click_button submit }

        xit { should have_title('Sign up') }
        xit { should have_content('error') }
      end  

    end

    describe "with valid information" do
      before do
        fill_in "Name",  with: "Example User"
        fill_in "Email", with: "user@example.com"
        fill_in "Password", with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end

      xit "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end

      describe "after saving the user" do
        before { click_button submit }
        let(:user) { User.find_by(email: 'user@example.com') }

        xit { should have_link('Logout') }
        xit { should have_title(user.name) }
        xit { should have_selector('div.alert.alert-success', text: 'Welcome') }
      end
    end
  end
end