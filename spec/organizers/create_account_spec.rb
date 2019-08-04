require 'rails_helper'

RSpec.describe CreateAccount, type: :organizer do
  describe 'Behaviors' do
    context 'when attributes are valid' do
      let(:valid_attributes) { attributes_for(:account) }
      let(:result) { described_class.call(account_attributes: valid_attributes) }

      it 'is successfull' do
        expect(result).to be_success
      end

      it 'returns an account created with given attributes' do
        expect(result.account).to be_persisted
        expect(result.account.name).to eq valid_attributes[:name]
        expect(result.account.color).to eq valid_attributes[:color]
        expect(result.account.balance_currency).to eq valid_attributes[:balance_currency]
      end
    end

    context 'when attributes are invalid' do
      let(:invalid_attributes) { attributes_for(:account).except(:name) }
      let(:result) { described_class.call(account_attributes: invalid_attributes) }

      it 'is a failure' do
        expect(result).to be_failure
      end

      it 'returns a not persited account with errors' do
        expect(result.account).to_not be_persisted
        expect(result.account.errors).to_not be_empty
      end
    end
  end
end
