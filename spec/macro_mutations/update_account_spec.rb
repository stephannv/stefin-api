require 'rails_helper'

RSpec.describe UpdateAccount, type: :macro_mutation do
  describe '#execute' do
    let(:account) { create(:account) }
    let(:new_name) { Faker::Lorem.word }

    it 'updates an account with given attributes' do
      described_class.run!(account_id: account.id, account_attributes: { name: new_name })
      expect(account.reload.name).to eq new_name
    end
  end
end
