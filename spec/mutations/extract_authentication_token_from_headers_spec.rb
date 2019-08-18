require 'rails_helper'

RSpec.describe ExtractAuthenticationTokenFromHeaders, type: :mutation do
  describe '#execute' do
    let(:token) { 'tokenhere' }

    it 'extract token from authentication header' do
      extracted_token = described_class.run!(authorization_header: "Bearer #{token}")
      expect(extracted_token).to eq token
    end
  end
end
