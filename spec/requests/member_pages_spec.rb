require 'spec_helper'

describe "MemberPages" do

  subject { page }

  describe "login page" do

    before { visit login_path }

    it { should have_content('Log In') }
    it { should have_title(full_title('Log In')) }

  end

end
