require 'rails_helper'

RSpec.describe ListAccounts, type: :action do
  describe 'Promises' do
    it 'promises :accounts' do
      expect(described_class.promises).to include :accounts
    end
  end

  describe 'Behavior' do
    let(:account) { build(:account) }

    before do
      allow(Account).to receive(:all).and_return([account])
    end

    it 'adds all accounts to context' do
      context = described_class.execute
      expect(context.accounts).to eq [account]
    end
  end
end
