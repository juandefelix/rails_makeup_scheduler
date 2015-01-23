require 'spec_helper'

describe "Admin Calendar" do
  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  let(:admin) { FactoryGirl.create(:admin) }

  before { sign_in admin }


  describe "calendar without makeups available" do
    before { click_link "Admin Calendar" }

    it "should have the right content" do
      # save_and_open_page
      page.should have_css('h1', :text => "Admin Calendar")
      page.should have_css('.ec-calendar')
      page.should_not have_css('h1', :text => "Available Makeups")
    end

    it { should_not have_css('.ec-cancellation-1') }

  end

  describe "calendar with makeups available" do
    before do
      @cancellation = FactoryGirl.create(:cancellation)
      @cancellation.update_attribute(:start_at, Time.now)
      click_link "Admin Calendar"
    end

    it { should have_css('.ec-cancellation-1') }
  end
end