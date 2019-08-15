class CreateAccount < Mutations::Command
  required do
    hash :account_attributes do
      required do
        string :name
        string :color, matches: Utils::Color::HEX_COLOR_REGEX
        string :balance_currency, in: Money::Currency.to_a.map(&:iso_code)
      end
    end
  end

  def execute
    build_new_account
    assign_account_attributes
    save_account
    @account
  end

  private def build_new_account
    @account = BuildNewAccount.run!
  end

  private def assign_account_attributes
    AssignAccountAttributes.run!(account: @account, attributes: account_attributes)
  end

  private def save_account
    SaveAccount.run!(account: @account)
  end
end
