require 'spec_helper'

describe "TimeTests" do
  let(:user) { FactoryGirl.create(:user) }
  subject { page }

  before do 
    sign_in user, no_capybara: true
  end

  describe "Nofitifyng before 8:30 pm" do
    before do
      t = Time.local(2014, 9, 23, 7, 5, 0)
      Timecop.freeze(t)
      visit new_cancellation_path
      save_and_open_page
    end

    it { should have_content "notify"}
  end
end
