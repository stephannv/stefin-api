class UpdateAccount < Mutations::Command
  required do
    string :account_id

    hash :account_attributes do
      optional do
        string :name
        string :color, matches: /\A#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})\z/
      end
    end
  end

  def execute
    find_account
    assign_account_attributes
    save_account
    @account
  end

  private def find_account
    @account = FindAccount.run!(id: account_id)
  end

  private def assign_account_attributes
    AssignAccountAttributes.run!(account: @account, attributes: account_attributes)
  end

  private def save_account
    SaveAccount.run!(account: @account)
  end
end
