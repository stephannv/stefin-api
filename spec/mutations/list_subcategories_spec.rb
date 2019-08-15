require 'rails_helper'

RSpec.describe ListSubcategories, type: :mutation do
  describe '#execute' do
    let!(:subcategories) { create_list(:subcategory, 3) }

    it 'returns all subcategories' do
      expect(described_class.run!).to eq subcategories
    end
  end
end
