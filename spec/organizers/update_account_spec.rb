require 'rails_helper'

RSpec.describe UpdateAccount, type: :organizer do
  describe 'Behaviors' do
    let(:account) { create(:account) }

    context 'when attributes are valid' do
      let(:valid_attributes) { { name: Faker::Lorem.word } }
      let(:result) { described_class.call(account_id: account.id, account_attributes: valid_attributes) }

      it 'is successfull' do
        expect(result).to be_success
      end

      it 'returns an account updated with given attributes' do
        result.account.reload
        expect(result.account.name).to eq valid_attributes[:name]
      end
    end

    context 'when attributes are invalid' do
      let(:invalid_attributes) { { name: nil } }
      let(:result) { described_class.call(account_id: account.id, account_attributes: invalid_attributes) }

      it 'is a failure' do
        expect(result).to be_failure
      end

      it 'returns a not updated account with errors' do
        result.account.reload
        expect(result.account.name).to_not be_nil
        expect(result.account.errors).to_not be_empty
      end
    end
  end
end
