require 'spec_helper'

describe Cancellation do
  before { @cancellation = Cancellation.new(name: "Luis Solares", instrument:"guitar", date:"12-3-12", start_time:"12:00pm") }

  subject { @cancellation }

# respond_to attributes ===============================

  it { should respond_to(:name) }
  it { should respond_to(:instrument) }
  it { should respond_to(:date) }
  it { should respond_to(:start_time) }
  it { should_not respond_to(:end_time) }

  it { should be_valid }

# presence of attributes ===============================

  describe "when name is not present" do
    before { @cancellation.name = ""}
    it { should_not be_valid }
  end

  describe "when instrument is not present" do
    before { @cancellation.instrument = " "}
    it { should_not be_valid }
  end

  describe "when date is not present" do
    before { @cancellation.date = "" }
    it { should_not be_valid }
  end

  describe "when start_time is not present" do
    before { @cancellation.start_time = "" }
    it { should_not be_valid }
  end

  # describe "when end_time is not present" do
  #   before { @cancellation.end_time = "" }
  #   it { should_not be_valid }
  # end

# format of some attributes ==========================

  describe "when using invalid format for time_start and time_end" do
    wrong_times = %w[123pm 0123pm 01:23]
    wrong_times.each do |wrong_time|

      before { @cancellation.start_time = wrong_time }
      it { should_not be_valid }

      # before { @cancellation.end_time = wrong_time }
      # it { should_not be_valid }
    end
  end


  describe "when using valid formats for time_start and time_end" do
    valid_times = ['1:23 pm', '02:34 am', '01:23pm', '1:23am', '01:23  pm', '1:23  am']
    valid_times.each do |valid_time|

        before { @cancellation.start_time = valid_time }
        it { should be_valid}

        # before { @cancellation.end_time = valid_time }
        # it { should be_valid }
    end
  end
end

=begin
  
define the array of wrong adresses

for each one
  assign the start_time
  test @cancellation
  assing the end_time
  test @cancellation
  
=end
