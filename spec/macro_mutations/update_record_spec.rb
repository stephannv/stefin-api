require 'rails_helper'

RSpec.describe UpdateRecord, type: :macro_mutation do
  describe '#execute' do
    let(:record) { create(:record) }
    let(:new_amount) { Faker::Number.decimal(l_digits: 3).to_d(2) }

    before { described_class.run!(record_id: record.id, record_attributes: { amount: new_amount }) }

    it 'updates a record with given attributes' do
      expect(record.reload.amount.to_d).to eq new_amount
    end

    context 'when changes requires a account balance update' do
      it 'updates account balance' do
        expect(record.account.reload.balance.to_d).to eq new_amount * record.group_modifier
      end
    end
  end
end
