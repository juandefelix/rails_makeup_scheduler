require 'spec_helper'
require 'pry-byebug'

describe "Admin Calendar" do
  
  
  before do
    @user = FactoryGirl.create(:user, name: "Taker User")
    @admin = FactoryGirl.create(:admin)
    @cancellation = FactoryGirl.create(:cancellation, start_at: 2.days.from_now, taker: @user)
    facebook_sign_in
    visit edit_admin_cancellation_path @cancellation
  end

  it "has the right content" do
    expect(page).to have_content @cancellation.name
    expect(page).to have_content @cancellation.instrument
  end

  describe "Editing cancellation" do
    it 'Changing instrument' do
      fill_in "New Instrument",    with: "Balalaika"
      click_button 'Send'
      visit edit_admin_cancellation_path @cancellation
      expect(page).to have_content "Balalaika"
    end

    it 'Making it available' do
      page.should_not have_link "Delete cancellation"
      expect { click_link "Make it available" }.to change { @cancellation.reload.taker }.from(@user).to nil
    end

    it 'Deleting the cancellation' do
      click_link "Make it available"
      page.should_not have_link "Make it available"
      expect{ click_link "Delete cancellation" }.to change(Cancellation, :count).by -1
    end
  end
end
