class DestroyRecord < Mutations::Command
  required do
    model :record
  end

  def execute
    record.destroy!
  end
end
