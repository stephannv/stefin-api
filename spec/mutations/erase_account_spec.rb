require 'rails_helper'

RSpec.describe EraseAccount, type: :mutation do
  describe '#execute' do
    let(:account) { create(:account) }

    it 'finds account by id and destroys it' do
      described_class.run!(account_id: account.id)
      expect(Account.find_by(id: account.id)).to be_nil
    end
  end
end
