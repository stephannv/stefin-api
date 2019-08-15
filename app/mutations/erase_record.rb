class EraseRecord < Mutations::Command
  required do
    string :record_id
  end

  def execute
    ActiveRecord::Base.transaction do
      find_record
      destroy_record
      update_account_balance
    end
  end

  private def find_record
    @record = FindRecord.run!(id: record_id)
  end

  private def destroy_record
    DestroyRecord.run!(record: @record)
  end

  private def update_account_balance
    UpdateAccountBalance.run!(account: @record.account)
  end
end
