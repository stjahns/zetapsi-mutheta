require 'spec_helper'

describe Member do

  before do 
    @member = Member.new(name: "Joe Schmoe", email: "abc@xyz.com",
                        password: "foobar", password_confirmation: "foobar")
  end

  subject { @member }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:authenticate) }
  it { should respond_to(:remember_token) }

  it { should be_valid }

  describe "when name is not present" do
    before { @member.name = " " }
    it { should_not be_valid }
  end

  describe "when email is not present" do
    before { @member.email = " " }
    it { should_not be_valid }
  end

  describe "when email format is invalid" do
    it "should be valid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @member.email = invalid_address
        expect(@member).not_to be_valid
      end
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @member.email = valid_address
        expect(@member).to be_valid
      end
    end
  end

  describe "when email address is already taken" do
    before do
      member_with_same_email = @member.dup
      member_with_same_email.email = @member.email.upcase
      member_with_same_email.save
    end

    it {should_not be_valid }
  end

  describe "when password is not present" do
    before do
      @member = Member.new(name: "Joe Schmoe", email: "abc@xyz.com",
                        password: " ", password_confirmation: " ")
    end
    it { should_not be_valid }
  end

  describe "when password doesn't match confirmation" do
    before { @member.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end

  describe "return value of authenticate method" do
    before { @member.save }
    let(:found_member) { Member.find_by(email: @member.email) }

    describe "with valid password" do
      it { should eq found_member.authenticate(@member.password) }
    end

    describe "with invalid password" do
      let(:user_for_invalid_password) { found_member.authenticate("invalid") }
      it { should_not eq user_for_invalid_password }
      specify { expect(user_for_invalid_password).to be_false }
    end

    describe "with a password that's too short" do
      before { @member.password = @member.password_confirmation = "a" * 5 }
      it { should be_invalid }
    end
  end

  describe "remember token" do
    before { @member.save }
    its(:remember_token) { should_not be_blank }
  end
end
