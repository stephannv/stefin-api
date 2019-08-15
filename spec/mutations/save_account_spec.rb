require 'rails_helper'

RSpec.describe SaveAccount, type: :mutation do
  describe '#execute' do
    let(:account) { build(:account) }

    context 'when given attributes are valid' do
      it 'creates a new account with given attributes' do
        expect(account).to be_a_new(Account)
        described_class.run!(account: account)
        expect(account).to be_persisted
      end
    end

    context 'when given attributes are invalid' do
      it 'raises ActiveRecord::RecordInvalid error' do
        expect { described_class.run!(account: Account.new) }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end
end
