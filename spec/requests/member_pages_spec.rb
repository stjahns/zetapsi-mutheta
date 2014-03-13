require 'spec_helper'

describe "MemberPages" do

  before do 
    @member = Member.create(name: "Joe Schmoe", email: "abc@xyz.com",
                        password: "foobar", password_confirmation: "foobar")
  end

  subject { page }

  describe "login page" do

    before { visit login_path }

    it { should have_content('Log In') }
    it { should have_title(full_title('Log In')) }

  end

  describe "members index" do

    before { visit members_path }

    it { should have_content('Members') }
    it { should have_content('Joe Schmoe') }
    it { should have_title(full_title('Members')) }

    # TODO only if logged in (as administrator?)

    it { should have_content('Invite') }

    describe "sending valid invitation" do
      before do
        fill_in "Email", with: "123@xyz.com"
      end
      it "shoud add an invite" do
        expect { click_button "Invite" }.to change(MemberInvite, :count).by(1)
      end
    end

    describe "sending invite for existing member" do
      before do
        fill_in "Email", with: "abc@xyz.com"
      end

      it "should display message" do
        it { should have_content('Email address already in use') }
      end

      it "shoudn't add an invite" do
        expect { click_button "Invite" }.not_to change(MemberInvite, :count)
      end
    end

    it "clicking delete should delete user" do
      expect { click_link "Delete" }.to change(Member, :count).by(-1)
    end

    # TODO test that this doesn't work if not logged in / account doesn't have permissions

  end

  describe "show member page" do

    before { visit member_path(@member) }

    it { should have_content('Name: Joe Schmoe') }
    it { should have_title(full_title('Joe Schmoe')) }

  end

end
