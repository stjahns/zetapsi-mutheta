require 'spec_helper'

describe "MemberPages" do

  before do 
    @member = FactoryGirl.create(:member)
    ActionMailer::Base.deliveries = []
  end

  subject { page }
  
  #
  # Test member pages when not logged in
  #
  describe "members index while not logged in" do
    before { visit members_path }

    it { should_not have_content('Edit') }
    it { should_not have_content('Delete') }
    it { should_not have_content('Add') }

    # TODO test that edit, delete, and add are inaccessible / disabled otherwise

  end

  #
  # Test member pages for logged in members
  #
  describe "members index while logged in" do

    before do
      login_as(@member, :scope => :member)
      visit members_path
    end

    it { should have_content('Members') }
    it { should have_content(@member.name) }
    it { should have_title(full_title('Members')) }

    # basic users shouldn't be able to add / remove members
    it { should_not have_content('Add') }
  end

  #
  # Test member pages for logged in members
  #
  describe "members index while logged in as admin" do

    before do
      @admin = FactoryGirl.create(:admin)
      visit new_member_session_path
      login_as(@admin, :scope => :member)
      visit members_path
    end

    it { should have_content('Members') }
    it { should have_content(@member.name) }
    it { should have_title(full_title('Members')) }

    it { should have_content('Add') }

    it "clicking delete should delete user" do
      expect { first('.member_thumb').click_link "Delete" }.to change(Member, :count).by(-1)
    end

  end


  describe "show member page" do

    before { visit member_path(@member) }

    it { should have_content(@member.name) }
    it { should have_title(full_title(@member.name)) }

  end

  describe "edit member page" do

    before do 
      login_as(@member, :scope => :member)
      visit edit_member_path(@member)
    end

    it { should have_content("Edit Member") }
    it { should have_title(full_title("Edit member")) }

  end

end
