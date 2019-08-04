require 'rails_helper'

RSpec.describe DestroyAccount, type: :action do
  describe 'Expects' do
    it 'expects :account' do
      expect(described_class.expects).to include :account
    end
  end

  describe 'Behavior' do
    let(:account) { double(destroy: true) }

    it 'tries to destroy account' do
      expect(account).to receive(:destroy)
      described_class.execute(account: account)
    end

    context 'when account is destroyed' do
      it 'is successfull' do
        context = described_class.execute(account: account)
        expect(context).to be_success
      end
    end

    context 'when account isn`t destroyed' do
      let(:account) { double(destroy: false, errors: double(full_messages: ['message'])) }

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
