class TransactionsController < ApplicationController

  before_action :authenticate_member!
  load_and_authorize_resource

  def create
    @member = Member.find(params[:member_id])
    @transaction = @member.transactions.create(transaction_params)
    if @transaction.save
      AccountMailer.transaction_email(@transaction).deliver
      redirect_to @member
    else
      render 'edit'
    end
  end

  def index
    # no specfic template for member transactions, just redirect to member page
    @member = Member.find(params[:member_id])
    redirect_to @member
  end

  def show
    @member = Member.find(params[:member_id])
    @transaction = Transaction.find(params[:id])
  end

  def edit
    @member = Member.find(params[:member_id])
    @transaction = Transaction.find(params[:id])
  end

  def update
    @member = Member.find(params[:member_id])
    @transaction = @member.transactions.find(params[:id])
    if @transaction.update(transaction_params)
      redirect_to @member
    else
      render 'edit'
    end
  end

  def destroy
    @member = Member.find(params[:member_id])
    @transaction = @member.transactions.find(params[:id])
    @transaction.destroy
    redirect_to @member
  end

  private
    def transaction_params
      params.require(:transaction).permit(
        :type,
        :description,
        :amount,
        :receipt
      )
    end

end
