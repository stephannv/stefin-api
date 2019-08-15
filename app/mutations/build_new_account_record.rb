class BuildNewAccountRecord < Mutations::Command
  required do
    model :account
  end

  def execute
    account.records.new(amount_currency: account.balance_currency)
  end
end
