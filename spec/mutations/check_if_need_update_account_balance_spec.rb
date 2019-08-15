require 'rails_helper'

RSpec.describe CheckIfNeedUpdateAccountBalance, type: :mutation do
  describe '#execute' do
    let(:record_changes) { Record.new.attributes.except('amount_cents', 'group_modifier') }

    context 'when record changes includes amount_cents key' do
      it 'returns true' do
        record_changes[:amount_cents] = []
        expect(described_class.run!(record_changes: record_changes)).to eq true
      end
    end

    context 'when record changes includes group_modifier key' do
      it 'returns true' do
        record_changes[:group_modifier] = []
        expect(described_class.run!(record_changes: record_changes)).to eq true
      end
    end

    context 'when record changes doesn`t include amount_cents or group_modifier keys' do
      it 'returns false' do
        expect(described_class.run!(record_changes: record_changes)).to eq false
      end
    end
  end
end
