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

      describe "in the Invitations controller" do
          before { post invitations_path }
          specify { expect(response).to redirect_to(login_path) }
      end

      describe "in the Members controller" do

        describe "visiting the edit page" do 
          before { visit edit_member_path(member) }
          it { should have_title('Log in') }
        end

        describe "submitting to the update action" do
          before { patch member_path(member) }
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
