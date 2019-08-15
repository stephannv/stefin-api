class CalculateAccountBalance < Mutations::Command
  required do
    model :account
  end

  def execute
    Money.new(account.records.sum('amount_cents * group_modifier'), account.balance_currency)
  end
end
