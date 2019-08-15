require 'rails_helper'

RSpec.describe CreateAccount, type: :mutation do
  describe '#execute' do
    let(:account_attributes) { attributes_for(:account) }
    let(:account) { described_class.run!(account_attributes: account_attributes) }

    it 'creates a new account with given attributes' do
      expect(account).to be_persisted
      expect(account.name).to eq account_attributes[:name]
      expect(account.color).to eq account_attributes[:color]
      expect(account.balance_currency).to eq account_attributes[:balance_currency]
    end
  end
end
