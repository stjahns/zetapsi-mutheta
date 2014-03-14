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

  def current_user?(user)
    user == current_user
  end

  #
  # Redirect to login page if not signed in
  #
  def check_logged_in
    unless signed_in?
      store_location
      redirect_to login_url, notice: "Please sign in."
    end
  end

  #
  # Redirect to login page if not signed in as matching member
  #
  def check_correct_user
    member = Member.find(params[:id])
    unless current_user?(member)
      redirect_to(root_url) 
    end
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.url if request.get?
  end
end
