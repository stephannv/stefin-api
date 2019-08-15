class AssignRecordAttributes < Mutations::Command
  required do
    model :record, new_records: true
    hash :attributes do
      optional do
        string :group, in: Record.groups.keys
        string :account_id
        time :occurred_at
        model :amount, class: 'BigDecimal'

        string :title, discard_empty: true, max_length: 255
        string :description, discard_empty: true, max_length: 8192
      end
    end
  end

  def execute
    record.assign_attributes(attributes)
  end
end
