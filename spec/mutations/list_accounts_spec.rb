require 'rails_helper'

RSpec.describe ListAccounts, type: :mutation do
  describe '#execute' do
    let!(:accounts) { create_list(:account, 3) }

    it 'returns all accounts' do
      expect(described_class.run!).to eq accounts
    end
  end
end
