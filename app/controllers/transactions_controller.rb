class TransactionsController < ApplicationController

  def create
    @member = Member.find(params[:member_id])
    @transaction = @member.transactions.create(transaction_params)
    if @transaction.save
      redirect_to @member
    else
      render 'edit'
    end
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
