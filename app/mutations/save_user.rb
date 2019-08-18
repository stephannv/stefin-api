class SaveUser < Mutations::Command
  required do
    model :user, new_records: true
  end

  def execute
    user.save!
  end
end
