require 'spec_helper'

describe Cancellation do
  before { @cancellation = Cancellation.new(name: "Luis Solares", instrument:"guitar", date:"12-3-12", start_time:"12:00pm", end_time:"12:30pm") }

  subject { @cancellation }
  it { should respond_to(:name) }
  it { should respond_to(:instrument) }
  it { should respond_to(:date) }
  it { should respond_to(:start_time) }
  it { should respond_to(:end_time) }

  it { should be_valid }

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

  describe "when end_time is not present" do
    before { @cancellation.end_time = "" }
    it { should_not be_valid }
  end
end
