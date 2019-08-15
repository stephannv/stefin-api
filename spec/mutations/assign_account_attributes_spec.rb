require 'rails_helper'

RSpec.describe AssignAccountAttributes, type: :mutation do
  describe '#execute' do
    let(:account) { Account.new }
    let(:attributes) { build(:account).attributes.slice('name', 'color', 'balance') }

    it 'assigns attributes to given account' do
      described_class.run!(account: account, attributes: attributes)
      expect(account.attributes.slice('name', 'color', 'balance')).to eq attributes
    end
  end
end
