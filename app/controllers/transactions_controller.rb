class TransactionsController < ApplicationController

  def create
    @member = Member.find(params[:member_id])
    @transaction = @member.transactions.create(transaction_params)
    @transaction.save
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
    @transaction.update(transaction_params)
    puts "WTF!"
    puts params
    puts params[:transaction][:description] 
    puts @transaction.description
    redirect_to @member
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
