require 'rails_helper'

RSpec.describe FindAccount, type: :mutation do
  describe '#execute' do
    let(:account) { create(:account) }

    context 'when account exists' do
      it 'returns account with given id' do
        expect(described_class.run!(id: account.id)).to eq account
      end
    end

    context 'when account doesn`t exist' do
      it 'raises ActiveRecord::RecordNotFound error' do
        expect { described_class.run!(id: 'fake id') }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
