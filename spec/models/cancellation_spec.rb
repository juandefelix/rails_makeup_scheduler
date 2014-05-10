require 'pry'
require 'spec_helper'

describe Cancellation do

  before { @cancellation = Cancellation.new(name: "Luis Solares", instrument:"guitar", 
                                            start_at:"#{Time.now + 1.day + 30.minutes}", end_at:"#{Time.now + 1.day + 1.hour}") }

  subject { @cancellation }

# respond_to attributes ===============================

  it { should respond_to(:name) }
  it { should respond_to(:instrument) }
  it { should respond_to(:start_at) }
  it { should respond_to(:end_at) }

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


  describe "when start_time is not present" do
    before { @cancellation.start_at = "" }
    it { should_not be_valid }
  end

# format of some attributes ==========================

  describe "when using invalid format for start_at" do
    it "is not yet ready" do
      pending "because the cancellation model raises an error before the validations"
      this_should_not_get_executed
    end
  end

  

  describe "when using valid formats for start_at" do

    valid_times = ["#{(Time.now + 1.day).strftime("%Y-%m-%d %H:%M")}", "#{(Time.now + 2.days).strftime("%Y-%m-%d %H:%M")}"]
    # binding.pry
    valid_times.each do |valid_time|
      before { @cancellation.start_at = valid_time }
      it { should be_valid}
    end
  end

# time validations ==========================

  describe "when submiting a date in the past" do

    before do 
      @cancellation.start_at = "#{(Time.now - 1.hour)}"
      @cancellation.end_at = "#{(Time.now - 30.minutes)}"
    end
    it { should_not be_valid }
  end

  describe "when submiting a date that is too early" do

    before do
      @cancellation.start_at = "#{(Time.now - 22.hours)}"
      @cancellation.end_at = "#{(Time.now - 21.hours - 30.minutes)}"
    end
    it { should_not be_valid }
  end
end
