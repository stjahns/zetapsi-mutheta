class Charge < Transaction

  def credit_amount
    nil
  end

  def debit_amount
    amount
  end

  def balance_amount
    amount
  end

end
