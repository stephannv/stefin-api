require 'rails_helper'

RSpec.describe DestroyAccount, type: :mutation do
  describe '#execute' do
    let(:account) { create(:account) }

    context 'when account can be destroyed' do
      it 'destroys account' do
        described_class.run!(account: account)
        expect(account).to be_destroyed
      end
    end
  end
end
