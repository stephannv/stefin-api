require 'rails_helper'

RSpec.describe SaveAccount, type: :action do
  describe 'Expects' do
    it 'expects :account' do
      expect(described_class.expects).to include :account
    end
  end

  describe 'Promisses' do
    it 'promises :account' do
      expect(described_class.promises).to include :account
    end
  end

  describe 'Behavior' do
    let(:account) { double(save: true) }

    it 'tries to save account' do
      expect(account).to receive(:save)
      described_class.execute(account: account)
    end

    context 'when account is saved' do
      it 'is successfull' do
        context = described_class.execute(account: account)
        expect(context).to be_success
      end
    end

    context 'when account isn`t saved' do
      let(:account) { double(save: false, errors: double(full_messages: ['message'])) }

      it 'is a failure' do
        context = described_class.execute(account: account)
        expect(context).to be_failure
      end

      it 'adds message to context' do
        context = described_class.execute(account: account)
        expect(context.message).to eq 'message'
      end
    end
  end
end
