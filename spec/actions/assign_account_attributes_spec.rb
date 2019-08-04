require 'rails_helper'

RSpec.describe AssignAccountAttributes, type: :action do
  describe 'Expects' do
    it 'expects :account' do
      expect(described_class.expects).to include :account
    end

    it 'expects :account_attributes' do
      expect(described_class.expects).to include :account_attributes
    end
  end

  describe 'Promises' do
    it 'promises :account' do
      expect(described_class.promises).to include :account
    end
  end

  describe 'Behavior' do
    let(:account) { Account.new }
    let(:account_attributes) { { name: 'Account name' } }

    it 'assigns attributes to account' do
      context = described_class.execute(account: account, account_attributes: account_attributes)
      expect(context.account.name).to eq 'Account name'
    end
  end
end
