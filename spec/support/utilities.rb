include ApplicationHelper

def valid_sign_in(member)
  fill_in "Email", with: member.email
  fill_in "Password", with: member.password
  click_button "Sign in"
end
