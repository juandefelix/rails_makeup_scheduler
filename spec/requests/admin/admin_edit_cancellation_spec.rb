require 'spec_helper'

describe "Admin Calendar" do
  subject { page }

  let(:user) { FactoryGirl.create(:user, name: "Taker User") }
  let(:admin) { FactoryGirl.create(:admin) }
  let(:cancellation) { FactoryGirl.create(:cancellation, start_at: 2.days.from_now, taker: user) }
  
  before do
    sign_in admin
    visit edit_admin_cancellation_path cancellation
  end

  it "has the right content" do
    page.should have_content cancellation.name
    page.should have_content cancellation.instrument
  end

  describe "Editing cacellation" do
    it 'Changing instrument' do
      fill_in "New Instrument",    with: "Balalaika"
      click_button 'Send'
      visit edit_admin_cancellation_path cancellation
      page.should have_content "Balalaika"
    end

    it 'Making it available' do
      click_link "Make it available"
      expect(cancellation.reload.taker).to eq nil
      # this syntax doesn't work here!
      # expect{ click_link "Make it available" }.to change(cancellation, :taker).to nil
    end

    it 'Deleting the cancellation' do
      click_link "Make it available"
      expect{ click_link "Delete cancellation" }.to change(Cancellation, :count).by -1
    end
  end
end

