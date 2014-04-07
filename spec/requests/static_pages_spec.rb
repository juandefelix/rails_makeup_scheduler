require 'spec_helper'

describe "Static Pages" do
  describe "Home Page" do

    # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
    it "should have the content 'Makeup Scheduler'" do
      visit '/static_pages/home'
      expect(page).to have_content('Makeup Scheduler')
    end  

    it "should have the right title" do
      visit '/static_pages/home'
      expect(page).to have_title('Makeup Scheduler')
    end

    it "shoul not have a custom page title" do
      visit '/static_pages/home'
      expect(page).not_to have_title("| Home")
    end
  end

  describe "Help Page" do

    # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
    it "should have the content 'Help'" do
      visit '/static_pages/help'
      expect(page).to have_content('Help')
    end  

    it "should have the right title" do
      visit '/static_pages/help'
      expect(page).to have_title('Makeup Scheduler | Help')
    end
  end

  describe "About" do

    # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
    it "should have the content 'Help'" do
      visit '/static_pages/about'
      expect(page).to have_content('About')
    end  

    it "should have the right title" do
      visit '/static_pages/about'
      expect(page).to have_title('Makeup Scheduler | About')
    end
  end
end
