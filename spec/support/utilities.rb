include ApplicationHelper

def valid_login(member)
  fill_in "Email", with: member.email
  fill_in "Password", with: member.password
  click_button "Log in"
end

def sign_in(member, options={})
  if options[:no_capybara]
    # Sign in without using Capybara
    remember_token = Member.new_remember_token
    cookies[:remember_token] = remember_token
    member.update_attribute(:remember_token, Member.hash(remember_token))
  else
    visit login_path
    valid_login(member)
  end
end
