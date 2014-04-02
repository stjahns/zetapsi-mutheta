module TransactionsHelper
  def permissible_transactions(member)
    Transaction::TYPES.select do |t| 
      can? :create, member.transactions.build(type: t)
    end
  end
end
