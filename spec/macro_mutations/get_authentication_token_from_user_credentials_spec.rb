require 'rails_helper'

RSpec.describe GetAuthenticationTokenFromUserCredentials, type: :macro_mutation do
  describe '#execute' do
    let(:user) { create(:user) }
    let(:token) { described_class.run!(user_attributes: { email: user.email, password: user.password }) }

    it 'returns a valid jwt token from user credentials' do
      payload = Utils::Token.decode(token: token)
      expect(payload[:user_id]).to eq user.id
      expect(Time.zone.at(payload[:exp])).to be > Time.zone.now
    end
  end
end
