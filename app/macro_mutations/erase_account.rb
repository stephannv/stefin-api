class EraseAccount < Mutations::Command
  required do
    string :account_id
  end

  def execute
    find_account
    destroy_account
  end

  private def find_account
    @account = FindAccount.run!(id: account_id)
  end

  private def destroy_account
    DestroyAccount.run!(account: @account)
  end
end
