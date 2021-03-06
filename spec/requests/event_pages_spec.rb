require 'spec_helper'

describe "EventPages" do

  before do 
    @member = FactoryGirl.create(:member)
    @event_manager = FactoryGirl.create(:event_manager)
    @event = FactoryGirl.create(:event)
  end

  subject { page }

  describe "event index while not logged in" do
    before { visit events_path }

    it { should have_content('Events') }
    it { should have_content(@event.name) }
    it { should_not have_content('Edit') }
    it { should_not have_content('Delete') }
    it { should_not have_content('New Event') }

  end

  describe "event index while not logged in without event permissions" do
    before do
      login_as(@member, :scope => :member)
      visit events_path
    end

    it { should have_content('Events') }
    it { should have_content(@event.name) }
    it { should_not have_content('Edit') }
    it { should_not have_content('Delete') }
    it { should_not have_content('New Event') }

  end

  describe "event index while logged in with event permissions" do
    before do
      login_as(@event_manager, :scope => :member)
      visit events_path
    end

    it { should have_content('Events') }
    it { should have_content(@event.name) }
    it { should have_content('Edit') }
    it { should have_content('Delete') }
    it { should have_content('New Event') }

  end

end
