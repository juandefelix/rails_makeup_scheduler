require 'spec_helper'

describe "Day link" do
  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  let(:admin) { FactoryGirl.create(:admin) }

  before do 
    sign_in admin
  end
  

  describe 'empty day should not display a table' do
    before do
      visit "admin/cancellations/#{Time.now.year}/#{Time.now.month}/#{Time.now.day}"
    end

    it { should have_content "Cancellations for #{Time.now.month}"}
    its(:html) { should_not include('<table>') }
    it { should have_content "Sorry, no cancellations today!"}
  end

  describe 'day with absences should display a table' do
    before do 
      @cancellation = FactoryGirl.create(:cancellation)
      @cancellation.update_attribute(:start_at, Time.now)
      visit "admin/cancellations/#{Time.now.year}/#{Time.now.month}/#{Time.now.day}"
    end

    it { should have_content "Cancellations for #{Time.now.month}" }
    its(:html) { should include('table') }
    it { should have_content @cancellation.name }

    it { should_not have_content "Sorry, no cancellations today!"}
  end
end