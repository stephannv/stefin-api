require 'rails_helper'

RSpec.describe AssignRecordAttributes, type: :mutation do
  describe '#execute' do
    let(:record) { Record.new }
    let(:attributes) { { amount: 10.20.to_d, occurred_at: Time.zone.now } }

    it 'assigns attributes to given record' do
      described_class.run!(record: record, attributes: attributes)
      expect(record.amount.to_d).to eq attributes[:amount]
      expect(record.occurred_at).to eq attributes[:occurred_at]
    end
  end
end
