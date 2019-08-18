require 'rails_helper'

RSpec.describe DecodeAuthenticationToken, type: :mutation do
  describe '#execute' do
    let(:payload) { { 'key' => 'value' } }

    context 'when token is valid' do
      let(:token) { Utils::Token.encode(payload: payload, expiration_time_in_minutes: 10) }

      it 'decodes token' do
        decoded_payload = described_class.run!(token: token)
        expect(decoded_payload).to eq payload
      end
    end

    context 'when token is malformed' do
      it 'returns nil' do
        expect(described_class.run!(token: 'malformedtoken')).to be_nil
      end
    end

    context 'when token is expired' do
      let(:token) { Utils::Token.encode(payload: payload, expiration_time_in_minutes: -10) }

      it 'returns nil' do
        expect(described_class.run!(token: token)).to be_nil
      end
    end
  end
end
