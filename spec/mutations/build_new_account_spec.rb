require 'rails_helper'

RSpec.describe BuildNewAccount, type: :mutation do
  describe '#execute' do
    let(:account) { described_class.run! }

    it 'builds a new account' do
      expect(described_class.run!).to be_a_new(Account)
    end
  end
end
