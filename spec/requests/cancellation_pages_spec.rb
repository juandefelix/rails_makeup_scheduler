require 'spec_helper'

describe "Cancellation Pages" do
  subject { page }

  describe "cancellation page (single cancellation)" do
    let(:cancellation) { FactoryGirl.create(:cancellation) }
    before { visit cancellation_path(cancellation)}

    it { should have_content(cancellation.name) }
    it { should have_title("#{cancellation.name} #{cancellation.date}") }
  end

  describe "Notify and absence page" do
    before { visit new_cancellation_path }
    
    it { should have_title "Notify an absence"}
    it { should have_title(full_title("Notify an absence")) }
  end

  describe "Create an absence" do
    before { visit new_cancellation_path }

    let(:submit) { "Send" }

    describe "with invalid information" do
      it "should not create a cancellation" do
        expect { click_button submit }.not_to change(Cancellation, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "Student Name", with: "Joe Shidel"
        fill_in "Instrument", with: "Clarinet"
        fill_in "Date", with: "12/4/14"
        fill_in "Start time", with: "3:30pm"
        fill_in "End time", with: "4:00pm"
      end

      it "should create a user " do
        expect{ click_button submit }.to change(Cancellation, :count).by(1)
      end
    end
  end

  describe "Cancellations index page" do
    before { visit cancellations_path }

    it { should have_title full_title("Available Makeups") }
    it { should have_content("Available Makeups") }
    it { should have_content("Name") }
  end
end
