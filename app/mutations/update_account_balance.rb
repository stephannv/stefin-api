class UpdateAccountBalance < Mutations::Command
  required do
    model :account
  end

  def execute
    calculate_account_balance
    assign_account_attributes
    save_account
  end

  private def calculate_account_balance
    @account_balance = CalculateAccountBalance.run(account: account).result
  end

  private def assign_account_attributes
    AssignAccountAttributes.run!(account: account, attributes: { balance: @account_balance })
  end

  private def save_account
    SaveAccount.run!(account: account)
  end
end
