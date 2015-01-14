require 'spec_helper'

describe "Admin Pages" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  let(:admin) { FactoryGirl.create(:admin) }

  describe "All Users" do
    before do
      sign_in admin
      user
      click_link "All Users"
    end

    it "has the name of the users" do
      should have_link "Juan Ortiz"
      should have_link "#{user.name}"
    end

    it { should have_link('delete', href: admin_user_path(user)) }

    it "should be able to delete another user" do
      expect do
        click_link('delete', match: :first)
      end.to change(User, :count).by(-1)
    end

    it { should_not have_link('delete', href: user_path(admin)) }
  end

  describe "Admin Calendar" do
    before do
      sign_in admin
      click_link "Admin Calendar"
    end

    it "should have the right content" do
      # save_and_open_page
      page.should have_css('h1', :text => "Admin Calendar")
      page.should_not have_css('h1', :text => "Available Makeups")
    end
  end
end