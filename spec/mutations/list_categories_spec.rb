require 'rails_helper'

RSpec.describe ListCategories, type: :mutation do
  describe '#execute' do
    let!(:categories) { create_list(:category, 3) }

    it 'returns all categories' do
      expect(described_class.run!).to eq categories
    end
  end
end
