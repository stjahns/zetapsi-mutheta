class Reimbursement < Transaction

  def credit_amount
    amount
  end

  def debit_amount
    nil
  end

  def balance_amount
    amount
  end

end
