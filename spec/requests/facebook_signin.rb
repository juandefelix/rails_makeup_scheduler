require 'spec_helper'

describe "Facebook Authentication" do

  subject { page }
  let(:user) { FactoryGirl.create(:user)}

  describe "signin" do  
    before do
      sign_in user
    end

    describe "a test user" do

      it { should have_content "Notify an Absence" }
    end
  end
end
