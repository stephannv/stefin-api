require 'rails_helper'

RSpec.describe BuildNewUser, type: :mutation do
  describe '#execute' do
    let(:user) { described_class.run! }

    it 'builds a new user' do
      expect(described_class.run!).to be_a_new(User)
    end
  end
end
