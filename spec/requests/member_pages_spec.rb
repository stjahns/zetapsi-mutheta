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
    it { should_not have_content('Pending Invitations') }
    it { should_not have_content('Invite') }

    # TODO test that edit, delete, and invite are inaccessible / disabled otherwise

  end

  #
  # Test member pages for logged in members
  #
  describe "members index while logged in" do

    before do
      visit login_path
      fill_in "Email",    with: @member.email.upcase
      fill_in "Password", with: @member.password
      click_button "Log in"
      visit members_path
    end

    it { should have_content('Members') }
    it { should have_content(@member.name) }
    it { should have_title(full_title('Members')) }

    # TODO only if administrator?

    it { should have_content('Invite') }

    describe "with valid name and email" do

      let(:newname) { "newmember" }
      let(:newemail) { "newmember@abc.com" }

      before do
        fill_in "Name", with: newname
        fill_in "Email", with: newemail
      end

      it "shoud add an invite when click invite" do
        expect { click_button "Invite" }.to change(Invitation, :count).by(1)
      end

      describe "when click invite" do
        before { click_button "Invite" }
        it "should send email" do
          ActionMailer::Base.deliveries.last.should_not be_nil
          ActionMailer::Base.deliveries.last.to.should == [newemail]
        end
      end
    end

    describe "with existing email" do
      before do
        fill_in "Name", with: @member.name
        fill_in "Email", with: @member.email
      end

      it "shoudn't add an invite when click invite" do
        expect { click_button "Invite" }.not_to change(Invitation, :count)
      end

      describe "when click invite" do
        before { click_button "Invite" }
        it "should not send email" do
          ActionMailer::Base.deliveries.last.should be_nil
        end
      end
    end


    describe "with no name, email" do
      it "shoudn't add an invite when click invite" do
        expect { click_button "Invite" }.not_to change(Invitation, :count)
      end

      describe "when click invite" do
        before { click_button "Invite" }
        it "should not send email" do
          ActionMailer::Base.deliveries.last.should be_nil
        end
      end
    end

    it "clicking delete should delete user" do
      expect { click_link "Delete" }.to change(Member, :count).by(-1)
    end

  end

  describe "show member page" do

    before { visit member_path(@member) }

    it { should have_content("Name: #{@member.name}") }
    it { should have_title(full_title(@member.name)) }

  end

end
