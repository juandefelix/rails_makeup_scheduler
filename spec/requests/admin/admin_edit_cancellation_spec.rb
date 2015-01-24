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


end

describe "deleting cancellation" do
  let(:user) { FactoryGirl.create(:user, name: "Taker User") }
  let(:admin) { FactoryGirl.create(:admin) }
  let(:cancellation) { FactoryGirl.create(:cancellation, start_at: 2.days.from_now, taker: user) }

  it 'can undo a makeup' do
    sign_in admin
    visit edit_admin_cancellation_path cancellation
    click_link "Make it available"
    expect(cancellation.reload.taker).to eq(nil)
  end
  # it 'asdf' do  
    # click_link "Make it available" 
    # page.should_not have_link "Make it available"
    # page.should have_link "Delete cancellation"
    # expect { click_link "Delete cancellation" }.to change(Cancellation, :count).by(-1)
  # end
end
