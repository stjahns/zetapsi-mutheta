require 'spec_helper'

shared_examples "a transaction" do |transaction|
  describe transaction do
    it { should respond_to(:amount) }
    it { should respond_to(:description) }
    it { should respond_to(:member_id) }
    it { should respond_to(:receipt) }
    it { should respond_to(:created_at) }
    it { should_not respond_to(:lassie) }

    it { should be_valid }

    describe "invalid when description blank" do
      before { subject.send(:description=, " ") }
      it { should_not be_valid }
    end

    describe "invalid when amount 0" do
      before { subject.send(:amount=, 0) }
      it { should_not be_valid }
    end

    describe "invalid when amount negative" do
      before { subject.send(:amount=, -1) }
      it { should_not be_valid }
    end
  end 
end

describe ReimbursementRequest do
  before do 
    @request = FactoryGirl.create(:reimbursement_request)
    @member = FactoryGirl.create(:member)
  end

  subject { @request }

  it { should be_valid }

  it_should_behave_like "a transaction", @request

  describe "when add to member transactions" do
    it "should decrease member balance by amount" do
      expect do
        @member.transaction_ids = [@request.id]
        @member.save
      end.to change(@member, :account_balance).by(-@request.amount)
    end
  end

  describe "when receipt not present" do 
    before { @request.receipt = nil }
    it { should_not be_valid }
  end
end

describe Reimbursement do
  before do 
    @reimbursement = FactoryGirl.create(:reimbursement)
    @member = FactoryGirl.create(:member)
  end

  subject { @reimbursement }

  it { should be_valid }

  it_should_behave_like "a transaction", @reimbursement

  describe "when add to member transactions" do
    it "should increase member balance by amount" do
      expect do
        @member.transaction_ids = [@reimbursement.id]
        @member.save
      end.to change(@member, :account_balance).by(@reimbursement.amount)
    end
  end
end

describe Charge do
  before do 
    @charge = FactoryGirl.create(:charge)
    @member = FactoryGirl.create(:member)
  end

  subject { @charge }

  it_should_behave_like "a transaction", @charge

  describe "when add to member transactions" do
    it "should increase member balance by amount" do
      expect do
        @member.transaction_ids = [@charge.id]
        @member.save
      end.to change(@member, :account_balance).by(@charge.amount)
    end
  end
end

describe Payment do
  before do 
    @payment = FactoryGirl.create(:payment)
    @member = FactoryGirl.create(:member)
  end

  subject { @payment }

  it_should_behave_like "a transaction", @payment

  describe "when add to member transactions" do
    it "should decrease member balance by amount" do
      expect do
        @member.transaction_ids = [@payment.id]
        @member.save
      end.to change(@member, :account_balance).by(-@payment.amount)
    end
  end
end
