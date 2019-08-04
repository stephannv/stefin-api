require 'rails_helper'

RSpec.describe RetrieveAccount, type: :organizer do
  describe 'Behaviors' do
    context 'when account with given id exists' do
      let(:account) { create(:account) }
      let(:result) { described_class.call(account_id: account.id) }

      it 'is successfull' do
        expect(result).to be_success
      end

      it 'returns account' do
        expect(result.account).to eq account
      end
    end

    context 'when account doesn`t exists' do
      let(:result) { described_class.call(account_id: 'some-id') }

      it 'raises not found exception' do
        expect do
          described_class.call(account_id: 'some-id')
        end.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
