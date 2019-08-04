require 'rails_helper'

RSpec.describe EraseAccount, type: :organizer do
  describe 'Behaviors' do
    let(:account) { create(:account) }
    let!(:result) { described_class.call(account_id: account.id) }

    it 'is successfull' do
      expect(result).to be_success
    end

    it 'destroys account with given id' do
      expect(Account.find_by(id: account.id)).to be_nil
    end
  end
end
