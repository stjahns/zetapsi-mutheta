require 'spec_helper'

describe Member do

  before do 
    @member = Member.new(name: "Joe Schmoe", email: "abc@xyz.com",
                        password: "foobar123", password_confirmation: "foobar123")
  end

  subject { @member }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }

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
    it "should be invalid" do
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

end
