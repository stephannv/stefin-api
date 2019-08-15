require 'rails_helper'

RSpec.describe EraseRecord, type: :macro_mutation do
  describe '#execute' do
    let(:record) { create(:record) }

    it 'finds record by id and destroys it' do
      described_class.run!(record_id: record.id)
      expect(Record.find_by(id: record.id)).to be_nil
    end

    it 'updates account balance' do
      expect(record.account.reload.balance).to be_zero
    end
  end
end
