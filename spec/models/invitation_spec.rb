require 'spec_helper'

describe Invitation do
  before do 
    @invite = Invitation.new(name: "Joe Schmoe", email: "abc@xyz.com")
  end

  subject { @invite }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:email_token) }

  describe "when email address is already invited" do
    before do
      invite_with_same_email = @invite.dup
      invite_with_same_email.email = @invite.email.upcase
      invite_with_same_email.save
    end

    it {should_not be_valid }
  end

end
