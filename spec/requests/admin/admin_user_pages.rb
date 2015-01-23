require 'spec_helper'

describe "All Users" do
  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  let(:admin) { FactoryGirl.create(:admin) }

  before do
    sign_in admin
    user
    click_link "All Users"
  end

  it "has the name of the users" do
    should have_content 'All Users'
    should have_link "Juan Ortiz"
    should have_link "#{user.name}"
  end

  it { should have_link('delete', href: admin_user_path(user)) }

  it "should not be able to delete admin user" do 
    should_not have_link('delete', href: user_path(admin))
  end

  it "should be able to delete another user" do
    expect do
      click_link('delete', match: :first)
    end.to change(User, :count).by(-1)
  end

end
