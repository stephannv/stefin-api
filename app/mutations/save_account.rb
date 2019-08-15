class SaveAccount < Mutations::Command
  required do
    model :account, new_records: true
  end

  def execute
    account.save!
  end
end
