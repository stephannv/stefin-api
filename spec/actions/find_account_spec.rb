require 'rails_helper'

RSpec.describe FindAccount, type: :action do
  describe 'Expects' do
    it 'expects :account_id' do
      expect(described_class.expects).to include :account_id
    end
  end

  describe 'Promises' do
    it 'promises :account' do
      expect(described_class.promises).to include :account
    end
  end

  describe 'Behavior' do
    context 'find account' do
      let(:account) { build(:account, :with_id) }

      before do
        allow(Account).to receive(:find).with(account.id).and_return(account)
      end

      it 'is successfull' do
        context = described_class.execute(account_id: account.id)
        expect(context).to be_success
      end

      it 'adds account to context' do
        context = described_class.execute(account_id: account.id)
        expect(context.account).to eq account
      end
    end
  end
end
