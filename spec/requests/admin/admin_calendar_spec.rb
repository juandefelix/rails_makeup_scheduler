require 'spec_helper'

describe "Admin Calendar" do
  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  let(:admin) { FactoryGirl.create(:admin) }

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