require 'spec_helper'

describe "Authentication" do
  subject { page }

  describe "signin page" do

    before { visit signin_path }

    describe "with invalid information" do

      before { click_button "Sign in" }

      xit { should have_title "Sign In" }
      xit { should have_content "Sign In" }
      xit { should have_selector('div.alert.alert-error') }

      describe "after visiting another page" do

        before { click_link "Makeup Scheduler" }
        
        xit { should_not have_selector('div.alert.alert-error') }
      end
    end

    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        fill_in "Email",    with: user.email.upcase
        fill_in "Password", with: user.password
        click_button "Sign in"
      end

      xit { should have_title("Makeup Scheduler") }
      xit { should have_link('Profile',     href: user_path(user)) }
      xit { should have_link('Logout',    href: logout_path) }
      xit { should_not have_link('Sign in', href: signin_path) }
      xit { should have_link('Notify an Absence', href: new_cancellation_path) }
      xit { should have_link('Available Makeups', href: cancellations_path) }

      describe "followed by signout" do

        before { click_link "Logout" }
        xit { should have_link('Sign in') }
      end
    end
  end
end
