class ListAccounts < Mutations::Command
  def execute
    Account.all
  end
end
