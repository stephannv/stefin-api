require 'rails_helper'

RSpec.describe FindSubcategory, type: :mutation do
  describe '#execute' do
    let(:subcategory) { create(:subcategory) }

    context 'when subcategory exists' do
      it 'returns subcategory with given id' do
        expect(described_class.run!(id: subcategory.id)).to eq subcategory
      end
    end

    context 'when subcategory doesn`t exist' do
      it 'raises ActiveRecord::RecordNotFound error' do
        expect { described_class.run!(id: 'fake id') }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
