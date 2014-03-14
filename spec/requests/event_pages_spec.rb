require 'spec_helper'

describe "EventPages" do

  before do 
    @member = FactoryGirl.create(:member)
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

  describe "event index while logged in" do
    before do
      visit login_path
      fill_in "Email",    with: @member.email.upcase
      fill_in "Password", with: @member.password
      click_button "Log in"
      visit events_path
    end

    it { should have_content('Events') }
    it { should have_content(@event.name) }
    it { should have_content('Edit') }
    it { should have_content('Delete') }
    it { should have_content('New Event') }

  end

end
