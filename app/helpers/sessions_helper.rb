module SessionsHelper

  def sign_in(member)
    remember_token = Member.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    member.update_attribute(:remember_token, Member.hash(remember_token))
    self.current_user = member
  end

  def sign_out
    current_user.update_attribute(:remember_token,
                                  Member.hash(Member.new_remember_token))
    cookies.delete(:remember_token)
    self.current_user = nil
  end

  def signed_in?
    !current_user.nil?
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    remember_token = Member.hash(cookies[:remember_token])
    @current_user ||= Member.find_by(remember_token: remember_token)
  end

end
