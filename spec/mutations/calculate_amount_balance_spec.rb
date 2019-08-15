require 'rails_helper'

RSpec.describe CalculateAccountBalance, type: :mutation do
  describe '#execute' do
    let(:account) { create(:account) }
    let!(:record_1) { create(:record, :expense, account: account, amount: 100) }
    let!(:record_2) { create(:record, :income, account: account, amount: 20) }

    it 'builds a new account' do
      expect(described_class.run!(account: account)).to eq(-80.to_money(account.balance_currency))
    end
  end
end
