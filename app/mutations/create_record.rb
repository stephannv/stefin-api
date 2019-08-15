class CreateRecord < Mutations::Command
  required do
    hash :record_attributes do
      required do
        string :group, in: Record.groups.keys
        string :account_id
        time :occurred_at
        model :amount, class: 'BigDecimal'
      end

      optional do
        string :title, discard_empty: true
        string :description, discard_empty: true
      end
    end
  end

  def execute
    ActiveRecord::Base.transaction do
      find_account
      build_new_account_record
      assign_record_attributes
      save_record
      update_account_balance
      @record
    end
  end

  private def find_account
    @account = FindAccount.run!(id: record_attributes[:account_id])
  end

  private def build_new_account_record
    @record = BuildNewAccountRecord.run!(account: @account)
  end

  private def assign_record_attributes
    AssignRecordAttributes.run!(record: @record, attributes: record_attributes)
  end

  private def save_record
    SaveRecord.run!(record: @record)
  end

  private def update_account_balance
    UpdateAccountBalance.run!(account: @account)
  end
end
