require 'spec_helper'

describe "Admin Calendar" do
  subject { page }

  let(:user) { FactoryGirl.create(:user, name: "Taker User") }
  let(:admin) { FactoryGirl.create(:admin) }
  let(:cancellation) { FactoryGirl.create(:cancellation, start_at: 2.days.from_now, taker: user) }
  
  before do
    @cancellation = FactoryGirl.create(:cancellation, start_at: 2.days.from_now, taker: user)
    sign_in admin
    visit edit_admin_cancellation_path @cancellation
  end

  it "has the right content" do
    page.should have_content @cancellation.name
    page.should have_content @cancellation.instrument


    expect { click_link "Make it available" }.to change(user, :taken_cancellation_ids).from([1]).to([])
    expect(@cancellation.taker).to eq nil
    # specify(page.should have_link "Make it available"
      # expect(@cancellation.taker).to eq nil
  end

  describe "Making it available" do

    before do
      sign_in admin
      visit edit_admin_cancellation_path cancellation
      click_link "Make it available" 
    end
    
    it 'asdf' do  
      page.should_not have_link "Make it available"
      page.should have_link "Delete cancellation"
    end
  end
end

