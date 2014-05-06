require 'spec_helper'

describe Cancellation do

  before { @cancellation = Cancellation.new(name: "Luis Solares", instrument:"guitar", date: future_date, start_time:"20:30") }

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


# format of some attributes ==========================

  describe "when using invalid format for time_start and time_end" do
    wrong_times = %w(123pm 0123pm )
    wrong_times.each do |invalid_time|
      before { @cancellation.start_time = invalid_time }
      it { should_not be_valid }
    end
  end


  describe "when using valid formats for time_start and time_end" do

    valid_times = %w(1:23 02:34 01:23 1:23 01:23)
    valid_times.each do |valid_time|
      before { @cancellation.start_time = valid_time }
      it { should be_valid}
    end
  end

# time validations ==========================

  describe "when submiting a date in the past" do

    before { @cancellation.date = past_date }
    it { should_not be_valid }
  end

  describe "when submiting a date that is too early" do

    pending("is not yet created")
  end
end
