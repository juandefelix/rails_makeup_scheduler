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
      should have_content 'All Users'
      should have_link "Juan Ortiz"
      should have_link "#{user.name}"
    end

    it { should have_link('delete', href: admin_user_path(user)) }

    it "should not be able to delete admin user" do 
      should_not have_link('delete', href: user_path(admin))
    end

    it "should be able to delete another user" do
      expect do
        click_link('delete', match: :first)
      end.to change(User, :count).by(-1)
    end

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

    describe "Day link" do
      describe 'empty day should not display a table' do
        before do 
          click_link '1'
        end
        it { should have_content "Cancellations for 1"}

        its(:html) { should_not include('<table>') }
        it { should have_content "Sorry, no cancellations today!"}
      end

      describe 'day with absences should display a table' do
        before do 
          @cancellation = FactoryGirl.create(:cancellation)
          @cancellation.update_attribute(:start_at, Time.now.beginning_of_month)
          click_link '1'
        end

        it { should have_content "Cancellations for 1" }
        its(:html) { should include('table') }
        it { should have_content @cancellation.name }

        it { should_not have_content "Sorry, no cancellations today!"}
      end
    end
  end
end