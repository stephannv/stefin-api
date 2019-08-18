require 'rails_helper'

RSpec.describe FindUser, type: :mutation do
  describe '#execute' do
    let(:user) { create(:user) }

    context 'when user exists' do
      it 'returns user with given id' do
        expect(described_class.run!(id: user.id)).to eq user
      end
    end

    context 'when user doesn`t exist' do
      it 'raises ActiveRecord::RecordNotFound error' do
        expect { described_class.run!(id: 'fake id') }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
