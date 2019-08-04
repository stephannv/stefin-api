require 'rails_helper'

RSpec.describe InitializeAccount, type: :action do
  describe 'Promises' do
    it 'promises :account' do
      expect(described_class.promises).to include :account
    end
  end

  describe 'Behavior' do
    it 'adds a new account to context' do
      context = described_class.execute
      expect(context.account).to be_a_new(Account)
      expect(context.account.changes).to eq({})
    end
  end
end
