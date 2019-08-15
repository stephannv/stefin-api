class UpdateRecord < Mutations::Command
  required do
    string :record_id

    hash :record_attributes do
      optional do
        string :group, in: Record.groups.keys
        time :occurred_at
        model :amount, class: 'BigDecimal'
        string :subcategory_id
        string :title, discard_empty: true
        string :description, discard_empty: true
      end
    end
  end

  def execute
    ActiveRecord::Base.transaction do
      find_record
      assign_record_attributes
      capture_record_changes
      save_record
      update_account_balance if need_update_account_balance?
      @record
    end
  end

  private def find_record
    @record = FindRecord.run!(id: record_id)
  end

  private def assign_record_attributes
    AssignRecordAttributes.run!(record: @record, attributes: record_attributes)
  end

  private def capture_record_changes
    @record_changes = CaptureRecordChanges.run!(record: @record)
  end

  private def save_record
    SaveRecord.run!(record: @record)
  end

  private def need_update_account_balance?
    CheckIfNeedUpdateAccountBalance.run!(record_changes: @record_changes)
  end

  private def update_account_balance
    UpdateAccountBalance.run!(account: @record.account)
  end
end
