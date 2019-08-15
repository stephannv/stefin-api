class DestroyAccount < Mutations::Command
  required do
    model :account
  end

  def execute
    account.destroy!
  end
end
