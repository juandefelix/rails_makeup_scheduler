require 'spec_helper'

describe "Static Pages" do

  subject { page }

  describe "Home Page" do
    before { visit root_path }

    it { should have_content('Makeup Scheduler')}
    it { should have_title('Makeup Scheduler') }
    it { should_not have_title("| Home") }
  end

  describe "Help Page" do
    before { visit help_path }
  
    it { should have_content('Help') }
    it { should have_title('Makeup Scheduler | Help') }
  end

  describe "About" do
    before { visit about_path }

    it { should have_content('About') }
    it { should have_title('Makeup Scheduler | About') }
  end
end
