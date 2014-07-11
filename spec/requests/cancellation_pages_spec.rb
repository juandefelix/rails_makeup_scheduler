require 'spec_helper'

describe "Cancellation Pages" do
  subject { page }
  let(:user) { FactoryGirl.create(:user) }
  let(:another_user) { FactoryGirl.create(:user) }

  before do # a user is signed in
    visit signin_path
    fill_in "Email",    with: user.email.upcase
    fill_in "Password", with: user.password
    click_button "Sign in"
  end  

  describe "Cancellation show" do
    let(:cancellation) { FactoryGirl.create(:cancellation, creator: user) }

    before { visit cancellation_path(cancellation) }

    it { should have_content(cancellation.name) }
    it { should have_title(full_title("#{cancellation.instrument} #{cancellation.start_at.strftime("%m-%d-%y")}")) }
  end

  describe "Cancellationa new (Notify and absence page)" do
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
        select "3:30 pm", :from => "Start time" 
      end

      it "should create a user " do
        expect { click_button submit }.to change(Cancellation, :count).by 1
      end
    end
  end

  describe "Cancellations index page" do
    before do 
      2.times { FactoryGirl.create(:cancellation) }
      FactoryGirl.create(:cancellation, instrument: "Clarinet", creator: another_user )
      visit cancellations_path 
    end

    describe "should have the right content and title" do
      it { should have_title full_title("Available Makeups") }
      it { should have_content("Available Makeups") }
      it { should have_content "Clarinet #{25.hours.from_now.strftime("%-I:%M%p")}" }
    end

    it "should have the right number" do
      expect(Cancellation.count).to eq 3
    end

    describe "should list each cancellation" do
      Cancellation.all.each do |cancellation|
        it { should have_content(cancellation.instrument) } 
        it { have_selector('a') }
      end
    end

  end

  describe 'A user taking a cancellation' do
    let(:cancellation) { FactoryGirl.create(:cancellation, creator: another_user) }

    before do
      visit edit_cancellation_path cancellation
    end

    it { should have_content "Instrument: #{cancellation.instrument}" }
    it { should have_link "Take this spot" }

    describe 'in the present day or in the future' do
      before { click_link "Take this spot"}

      it { should have_content "#{user.name}"}      
    end

    describe 'in the past' do
      # let(:cancellation) { FactoryGirl.create(:cancellation, creator: another_user) }
      @cancellation = Cancellation.new(name: Faker::Name.name, instrument: "Guitar", start_at: "#{25.hours.from_now.strftime("%Y-%m-%d %H:%M")}", creator_id: 1)
      @cancellation.start_at = "#{1.day.ago.strftime("%Y-%m-%d %H:%M")}"

      before do
        puts "\n\n\n\n#{cancellation.start_at}\n\n\n\n"
        puts "\n\n\n\n#{cancellation.start_at}\n\n\n\n"
        cancellation.save
        visit edit_cancellation_path @cancellation
      end

      it 'test' do
      #   puts cancellation.start_at

        puts page.html
      end

      it { should_not have_link "Take this spot" }
    end
  end



  describe "delete cancellations" do
    let(:cancellation) { FactoryGirl.create(:cancellation) }

    before do
      cancellation.save
      user.add_role :admin
      visit edit_cancellation_path cancellation
    end

    it { should have_link("delete cancellation", href: cancellation_path(cancellation) ) }

    it "should be able to delete a cancellation" do
      expect { click_link 'delete cancellation' }.to change(Cancellation, :count).by -1
    end
  end
end

# questions:
# - what is the scope of FactoryGirl:create:cancellation. Do they exist after the 'describe' block is closed?
#   - No, it does not exist after exiting the 'before' block   