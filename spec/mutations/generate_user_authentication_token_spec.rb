require 'rails_helper'

RSpec.describe GenerateUserAuthenticationToken, type: :mutation do
  describe '#execute' do
    let(:user) { create(:user) }
    let(:token) { described_class.run!(user: user) }

    it 'returns a jwt token with expiration date to 7 days from now' do
      payload = Utils::Token.decode(token: token)
      expect(payload[:user_id]).to eq user.id
      expect(payload[:exp]).to eq 7.days.from_now.to_i
    end
  end
end
