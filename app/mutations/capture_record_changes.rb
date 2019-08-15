class CaptureRecordChanges < Mutations::Command
  required do
    model :record
  end

  def execute
    record.changes
  end
end
