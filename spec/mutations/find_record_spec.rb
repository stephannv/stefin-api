require 'rails_helper'

RSpec.describe FindRecord, type: :mutation do
  describe '#execute' do
    let(:record)  { create(:record) }

    context 'when record exists' do
      it 'returns record with given id' do
        expect(described_class.run!(id: record.id)).to eq record
      end
    end

    context 'when record doesn`t exist' do
      it 'raises ActiveRecord::RecordNotFound error' do
        expect { described_class.run!(id: 'fake id') }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
