require 'rails_helper'

RSpec.describe SaveRecord, type: :mutation do
  describe '#execute' do
    let(:record) { build(:record, account: create(:account)) }

    context 'when given attributes are valid' do
      it 'creates a new record with given attributes' do
        expect(record).to be_a_new(Record)
        described_class.run!(record: record)
        expect(record).to be_persisted
      end
    end

    context 'when given attributes are invalid' do
      it 'raises ActiveRecord::RecordInvalid error' do
        expect { described_class.run!(record: Record.new) }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end
end
