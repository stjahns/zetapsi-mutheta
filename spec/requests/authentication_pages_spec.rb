require 'spec_helper'

describe "Authentication" do

  subject { page }

  describe "signin page" do
    before { visit new_member_session_path }

    it { should have_content('Sign in') }
    it { should have_title('Sign in') }
  end

  describe "logging in" do
    before { visit new_member_session_path }

    describe "with invalid information" do
      before { click_button "Sign in" }

      it { should have_content('Sign in') } # same page
      it { should have_selector('div.alert.alert-alert') }

      # error flash should go away!
      describe "after visiting another page" do
        before { click_link "Home" }
        it { should_not have_selector('div.alert.alert-alert') }
      end
    end

    describe "with valid information" do
      let(:member) { FactoryGirl.create(:member) }

      before do
        fill_in "Email",    with: member.email.upcase
        fill_in "Password", with: member.password
        click_button "Sign in"
      end

      it { should have_link(member.email, href: member_path(member)) }
      it { should have_link('Sign out',    href: destroy_member_session_path) }
      it { should_not have_link('Sign in',    href: new_member_session_path) }

      describe "followed by sign out" do
        before { click_link "Sign out" }
        it { should have_link 'Sign in' }
      end
    end
  end

  describe "authorization" do

    describe "for non-signed-in users" do
      let (:member) { FactoryGirl.create(:member) }
      let (:admin) { FactoryGirl.create(:admin) }
      let (:event) { FactoryGirl.create(:event) }
      let (:album) { FactoryGirl.create(:album) }

      describe "when attempting to visit a protected page" do
        describe "like edit member" do
          before do
            visit edit_member_path(member)
            valid_sign_in(member)
          end
          describe "after signing in" do
            it "should render the desired protected page" do
              expect(page).to have_title(full_title('Edit member'))
            end
          end
        end
        describe "like new event" do
          before do
            visit new_event_path
            valid_sign_in(admin)
          end
          describe "after signing in as admin" do
            it "should render the desired protected page" do
              expect(page).to have_title(full_title('New event'))
            end
          end
        end
      end

      describe "in the Events controller" do
        describe "visit edit page" do
          before { visit edit_event_path(event) }
          it { should have_title('Sign in') }
        end
        describe "submit to create action" do
          before { post events_path }
          specify { expect(response).to redirect_to(new_member_session_path) }
        end
        describe "submit to update action" do
          before { patch event_path(event) }
          specify { expect(response).to redirect_to(new_member_session_path) }
        end
        describe "submit to destroy action" do
          before { delete event_path(event) }
          specify { expect(response).to redirect_to(new_member_session_path) }
        end
      end

      describe "in the Albums controller" do
        describe "visit edit page" do
          before { visit edit_album_path(album) }
          it { should have_title('Sign in') }
        end
        describe "submit to create action" do
          before { post albums_path }
          specify { expect(response).to redirect_to(new_member_session_path) }
        end
        describe "submit to update action" do
          before { patch album_path(album) }
          specify { expect(response).to redirect_to(new_member_session_path) }
        end
        describe "submit to destroy action" do
          before { delete album_path(album) }
          specify { expect(response).to redirect_to(new_member_session_path) }
        end
      end

      describe "in the Members controller" do

        describe "visiting the edit page" do 
          before { visit edit_member_path(member) }
          it { should have_title('Sign in') }
        end

        describe "submit to create action" do
          before { post members_path }
          specify { expect(response).to redirect_to(new_member_session_path) }
        end

        describe "submitting to the update action" do
          before { patch member_path(member) }
          specify { expect(response).to redirect_to(new_member_session_path) }
        end


        describe "submit to destroy action" do
          before { delete member_path(member) }
          specify { expect(response).to redirect_to(new_member_session_path) }
        end

      end
    end

    describe "as wrong user" do
      let (:member) { FactoryGirl.create(:member) }
      let (:wrong_member) { FactoryGirl.create(:member, email: "wrong@example.com") }

      #before { sign_in member, no_capybara: true }
      before { login_as(member, :scope => :member) }

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
