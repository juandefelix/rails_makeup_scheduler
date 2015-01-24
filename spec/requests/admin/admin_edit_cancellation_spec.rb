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
    it 'Making it available' do
      click_link "Make it available"
      expect(cancellation.reload.taker).to eq(nil)
    end

    # it 'Deleting the cancellation' do
      # click_link "Make it available"
      # click_link "Make it available"
    # end
  end

end

