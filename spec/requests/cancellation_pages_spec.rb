require 'spec_helper'

describe "Cancellation Pages" do
  subject { page }

  describe "GET /cancellation_pages" do
    before { visit new_cancellation_path }
    
    it { should have_title "Notify an absence"}
    it { should have_title(full_title("Notify an absence")) }
  end
end
