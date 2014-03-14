require 'spec_helper'

describe "Authentication" do

  subject { page }

  describe "login page" do
    before { visit login_path }

    it { should have_content('Log in') }
    it { should have_title('Log in') }
  end

  describe "logging in" do
    before { visit login_path }

    describe "with invalid information" do
      before { click_button "Log in" }

      it { should have_title('Log in') } # same page
      it { should have_selector('div.alert.alert-error') }

      # error flash should go away!
      describe "after visiting another page" do
        before { click_link "Home" }
        it { should_not have_selector('div.alert.alert-error') }
      end
    end

    describe "with valid information" do
      let(:member) { FactoryGirl.create(:member) }

      before do
        fill_in "Email",    with: member.email.upcase
        fill_in "Password", with: member.password
        click_button "Log in"
      end

      it { should have_title(member.name) }
      it { should have_link(member.email, href: member_path(member)) }
      it { should have_link('Log out',    href: logout_path) }
      it { should_not have_link('Log in',    href: login_path) }

      describe "followed by log out" do
        before { click_link "Log out" }
        it { should have_link 'Log in' }
      end
    end
  end

  describe "authorization" do

    describe "for non-signed-in users" do
      let (:member) { FactoryGirl.create(:member) }
      let (:event) { FactoryGirl.create(:event) }
      let (:album) { FactoryGirl.create(:album) }
      let (:invitation) { FactoryGirl.create(:invitation) }

      describe "in the Events controller" do
        describe "visit edit page" do
          before { visit edit_event_path(event) }
          it { should have_title('Log in') }
        end
        describe "submit to create action" do
          before { post events_path }
          specify { expect(response).to redirect_to(login_path) }
        end
        describe "submit to update action" do
          before { patch event_path(event) }
          specify { expect(response).to redirect_to(login_path) }
        end
        describe "submit to destroy action" do
          before { delete event_path(event) }
          specify { expect(response).to redirect_to(login_path) }
        end
      end

      describe "in the Albums controller" do
        describe "visit edit page" do
          before { visit edit_album_path(album) }
          it { should have_title('Log in') }
        end
        describe "submit to create action" do
          before { post albums_path }
          specify { expect(response).to redirect_to(login_path) }
        end
        describe "submit to update action" do
          before { patch album_path(album) }
          specify { expect(response).to redirect_to(login_path) }
        end
        describe "submit to destroy action" do
          before { delete album_path(album) }
          specify { expect(response).to redirect_to(login_path) }
        end
      end

      describe "in the Invitations controller" do
        describe "submit to create action" do
          before { post invitations_path }
          specify { expect(response).to redirect_to(login_path) }
        end
        describe "submit to destroy action" do
          before { delete invitation_path(invitation) }
          specify { expect(response).to redirect_to(login_path) }
        end
      end

      describe "in the Members controller" do

        describe "visiting the edit page" do 
          before { visit edit_member_path(member) }
          it { should have_title('Log in') }
        end

        describe "submit to create action" do
          before { post members_path }
          specify { expect(response).to redirect_to(login_path) }
        end

        describe "submitting to the update action" do
          before { patch member_path(member) }
          specify { expect(response).to redirect_to(login_path) }
        end


        describe "submit to destroy action" do
          before { delete member_path(member) }
          specify { expect(response).to redirect_to(login_path) }
        end

      end
    end

    describe "as wrong user" do
      let (:member) { FactoryGirl.create(:member) }
      let (:wrong_member) { FactoryGirl.create(:member, email: "wrong@example.com") }

      before { sign_in member, no_capybara: true }

      describe "submitting a GET request to the Members#edit action" do
        before { get edit_member_path(wrong_member) }
        specify { expect(response.body).not_to match(full_title('Edit Member')) }
        specify { expect(response).to redirect_to(root_url) }
      end

      describe "submitting a Patch request to the Members#update action" do
        before { patch member_path(wrong_member) }
        specify { expect(response).to redirect_to(root_url) }
      end

    end
  end
end
