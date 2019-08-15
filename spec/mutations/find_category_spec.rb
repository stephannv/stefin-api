require 'rails_helper'

RSpec.describe FindCategory, type: :mutation do
  describe '#execute' do
    let(:category) { create(:category) }

    context 'when category exists' do
      it 'returns category with given id' do
        expect(described_class.run!(id: category.id)).to eq category
      end
    end

    context 'when category doesn`t exist' do
      it 'raises ActiveRecord::RecordNotFound error' do
        expect { described_class.run!(id: 'fake id') }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
