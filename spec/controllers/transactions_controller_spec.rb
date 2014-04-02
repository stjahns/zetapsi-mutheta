require 'spec_helper'

describe TransactionsController do

  before do
    @member = FactoryGirl.create(:member)
    @charge_transaction = FactoryGirl.create(:charge, member: @member)

    @another_member = FactoryGirl.create(:member)
    @another_charge_transaction = FactoryGirl.create(:charge, member: @another_member)
  end

  describe "while not signed in" do

    describe "GET index" do
      it "should redirect to sign in page" do
        get :index, member_id: @member.id
        response.should redirect_to new_member_session_path
      end
    end

    describe "POST create" do
      it "should redirect to sign in page" do
        post :create, member_id: @member.id, transaction: FactoryGirl.attributes_for(:charge)
        response.should redirect_to new_member_session_path
      end
    end

    describe "GET show" do
      it "should redirect to sign in page" do
        get :show, member_id: @member.id, id: @charge_transaction.id
        response.should redirect_to new_member_session_path
      end
    end
  end

  describe "while signed in as basic user" do

    before { sign_in @member }

    describe "GET index" do
      # no member transactions index page (for now)
      # transactions are just viewable in the member show page
      it "should redirect to member page" do
        get :index, member_id: @member.id
        response.should redirect_to @member
      end
    end

    ### basic members should only be able to create reimbursement requests

    describe "POST create charge" do
      it "should not create transaction" do
        expect {
          post :create, member_id: @member.id,
            transaction: FactoryGirl.attributes_for(:charge)
        }.not_to change(Transaction, :count)
      end
    end

    describe "POST create reimbursement" do
      it "should not create transaction" do
        expect {
          post :create, member_id: @member.id,
            transaction: FactoryGirl.attributes_for(:reimbursement)
        }.not_to change(Transaction, :count)
      end
    end

    describe "POST create payment" do
      it "should not create transaction" do
        expect {
          post :create, member_id: @member.id,
            transaction: FactoryGirl.attributes_for(:payment)
        }.not_to change(Transaction, :count)
      end
    end

    describe "POST create reimbursement_request" do
      it "should create transaction" do
        expect {
          post :create, member_id: @member.id,
            transaction: FactoryGirl.attributes_for(:reimbursement_request)
        }.to change(Transaction, :count).by(1)
      end

      it "should redirect to transaction" do
        # TODO figure out how to get the new ID for redirect, use mock_model?
      end
    end

    ### basic members should only be able to view their own transactions

    describe "GET show for own transaction" do
      it "should render show template" do
        get :show, member_id: @member.id, id: @charge_transaction.id
        response.should render_template("show")
      end
    end

    describe "GET show for another member's transaction" do
      it "should redirect after failing authorization" do
        get :show, member_id: @another_member.id, id: @another_charge_transaction.id
        response.should be_redirect
      end
    end

    ### basic members should only be able to delete, edit, update reimbursement requests
    # TODO !!!

  end
end
