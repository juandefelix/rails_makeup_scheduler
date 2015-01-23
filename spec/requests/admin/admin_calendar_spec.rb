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
    page.should have_css('.ec-calendar')
    page.should_not have_css('h1', :text => "Available Makeups")
  end
end