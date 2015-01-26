require 'spec_helper'

describe "TimeTests" do
  let(:user) { FactoryGirl.create(:user) }
  # let(:cancellation) { FactoryGirl.create(:cancellation) }
  subject { page }

  describe "Nofitifyng before 8:30 pm" do
    before do
      @cancellation = FactoryGirl.build(:cancellation, start_at: early_morning, creator: user)
    end

    it "should not be valid" do
      @cancellation.should_not be_valid
    end
  end

  describe "Nofitifyng in the past" do
    before do
      @cancellation = FactoryGirl.build(:cancellation, start_at: Time.now - 1.hour, creator: user)
    end

    it "should not be valid" do
      @cancellation.should_not be_valid
    end
  end

  describe "Nofitifyng before 24 hours" do
    before do
      @cancellation = FactoryGirl.build(:cancellation, start_at: Time.now + 22.hours, creator: user)
    end

    it "should not be valid" do
      @cancellation.should_not be_valid
    end
  end
end
