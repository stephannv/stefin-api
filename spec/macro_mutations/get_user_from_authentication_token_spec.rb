require 'rails_helper'

RSpec.describe GetUserFromAuthenticationToken, type: :macro_mutation do
  describe '#execute' do
    let(:user) { create(:user) }

    context 'when token is invalid' do
      let(:result) { described_class.run!(authorization_header: 'Bearer invalid.token.here') }

      it 'returns nil' do
        expect(result).to be_nil
      end
    end

    context 'when token is valid' do
      let(:user) { create(:user) }
      let(:token) { Utils::Token.encode(payload: { user_id: user.id }, expiration_time_in_minutes: 1000) }
      let(:result) { described_class.run!(authorization_header: "Bearer #{token}") }

      context 'when user exists' do
        it 'returns user' do
          expect(result).to eq user
        end
      end

      context 'when user doesn`t exists' do
        let(:token) { Utils::Token.encode(payload: { user_id: 'fake-id' }, expiration_time_in_minutes: 1000) }

        it 'returns nil' do
          expect(result).to be_nil
        end
      end
    end
  end
end
