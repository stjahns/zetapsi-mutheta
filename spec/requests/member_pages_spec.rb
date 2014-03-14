require 'spec_helper'

describe "MemberPages" do

  before do 
    @member = Member.create(name: "Joe Schmoe", email: "abc@xyz.com",
                        password: "foobar", password_confirmation: "foobar")
    ActionMailer::Base.deliveries = []
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

    describe "with valid name and email" do
      before do
        fill_in "Name", with: "Joe Schmoe"
        fill_in "Email", with: "123@xyz.com"
      end

      it "shoud add an invite when click invite" do
        expect { click_button "Invite" }.to change(Invitation, :count).by(1)
      end

      describe "when click invite" do
        before { click_button "Invite" }
        it "should send email" do
          ActionMailer::Base.deliveries.last.should_not be_nil
          ActionMailer::Base.deliveries.last.to.should == ["123@xyz.com"]
        end
      end
    end

    describe "with existing email" do
      before do
        fill_in "Name", with: "Joe Schmoe"
        fill_in "Email", with: "abc@xyz.com"
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

    it { should have_content('Name: Joe Schmoe') }
    it { should have_title(full_title('Joe Schmoe')) }

  end

end
