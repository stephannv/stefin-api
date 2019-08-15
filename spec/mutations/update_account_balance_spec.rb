require 'rails_helper'

RSpec.describe UpdateAccountBalance, type: :mutation do
  describe '#execute' do
    let(:account) { create(:account) }
    let!(:record) { create(:record, account: account) }

    it 'updates an account with given attributes' do
      expect(account.balance).to be_zero
      described_class.run!(account: account)
      expect(account.reload.balance).to eq record.amount * record.group_modifier
    end
  end
end
