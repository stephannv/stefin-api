require 'rails_helper'

RSpec.describe CreateCategory, type: :macro_mutation do
  describe '#execute' do
    let(:category_attributes) { attributes_for(:category) }
    let(:category) { described_class.run!(category_attributes: category_attributes) }

    it 'creates a new category with given attributes' do
      expect(category).to be_persisted
      expect(category.name).to eq category_attributes[:name]
      expect(category.color).to eq category_attributes[:color]
      expect(category.icon).to eq category_attributes[:icon]
    end
  end
end
