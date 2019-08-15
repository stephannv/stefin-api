require 'rails_helper'

RSpec.describe CreateRecord, type: :macro_mutation do
  describe '#execute' do
    let!(:account) { create(:account) }
    let(:record) { build(:record, account: account, subcategory: create(:subcategory)) }
    let(:record_attributes) do
      {
        group: record.group,
        occurred_at: record.occurred_at,
        account_id: account.id,
        amount: record.amount.to_d,
        subcategory_id: record.subcategory.id
      }
    end
    let(:created_record) { described_class.run!(record_attributes: record_attributes) }

    it 'creates a new record with given attributes' do
      expect(created_record).to be_persisted
      expect(created_record.group).to eq record_attributes[:group]
      expect(created_record.occurred_at).to eq record_attributes[:occurred_at]
      expect(created_record.account_id).to eq record_attributes[:account_id]
      expect(created_record.amount.to_d).to eq record_attributes[:amount]
      expect(created_record.subcategory_id).to eq record_attributes[:subcategory_id]
    end

    it 'updates account balance' do
      record = described_class.run!(record_attributes: record_attributes)
      expect(account.reload.balance).to eq(record.amount * record.group_modifier)
    end
  end
end
