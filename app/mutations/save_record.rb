class SaveRecord < Mutations::Command
  required do
    model :record, new_records: true
  end

  def execute
    record.save!
  end
end
