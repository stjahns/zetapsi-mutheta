class ReimbursementRequest < Transaction
  include CreditingTransaction

  validates :receipt, presence: true
end
