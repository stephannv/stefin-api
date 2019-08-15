require 'rails_helper'

RSpec.describe DestroyRecord, type: :mutation do
  describe '#execute' do
    let(:record) { create(:record) }

    context 'when record can be destroyed' do
      it 'destroys record' do
        described_class.run!(record: record)
        expect(record).to be_destroyed
      end
    end
  end
end
