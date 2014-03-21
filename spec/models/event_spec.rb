require 'spec_helper'

describe Event do

  before do 
    @event = FactoryGirl.create(:event)
  end

  subject { @event }

  it { should respond_to :name }
  it { should respond_to :description }
  it { should respond_to :start_time }
  it { should respond_to :has_end }
  it { should respond_to :end_time }

  it { should be_valid }

  describe "with no name" do
    before { @event.name = " " }
    it { should_not be_valid }
  end

  describe "with no description" do
    before { @event.description = " " }
    it { should_not be_valid }
  end

  describe "with no start time" do
    before { @event.start_time = nil }
    it { should_not be_valid }
  end

  describe "with start time after end time" do
    before { @event.start_time = @event.end_time + 1.second }
    it { should_not be_valid }
  end

  describe "with start time the same as end time" do
    before { @event.start_time = @event.end_time }
    it { should be_valid }
  end

end
