require 'rails_helper'

RSpec.describe CreateSubcategory, type: :macro_mutation do
  describe '#execute' do
    let(:subcategory_attributes) { attributes_for(:subcategory, category_id: create(:category).id) }
    let(:subcategory) { described_class.run!(subcategory_attributes: subcategory_attributes) }

    it 'creates a new subcategory with given attributes' do
      expect(subcategory).to be_persisted
      expect(subcategory.category_id).to eq subcategory_attributes[:category_id]
      expect(subcategory.name).to eq subcategory_attributes[:name]
      expect(subcategory.icon).to eq subcategory_attributes[:icon]
    end
  end
end
