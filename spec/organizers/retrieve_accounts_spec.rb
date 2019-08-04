require 'rails_helper'

RSpec.describe RetrieveAccounts, type: :organizer do
  describe 'Behaviors' do
    let!(:account) { create(:account) }
    let(:result) { described_class.call }

    it 'is successfull' do
      expect(result).to be_success
    end

    it 'returns all accounts' do
      expect(result.accounts).to eq [account]
    end
  end
end
