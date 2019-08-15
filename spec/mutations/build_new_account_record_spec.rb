require 'rails_helper'

RSpec.describe BuildNewAccountRecord, type: :mutation do
  describe '#execute' do
    let(:account) { create(:account) }
    let(:record) { described_class.run!(account: account) }

    it 'builds a new record with account id and amount currency already filled' do
      expect(record).to be_a_new(Record)
      expect(record.account_id).to eq account.id
      expect(record.amount_currency).to eq account.balance_currency
    end
  end
end
