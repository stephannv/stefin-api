require 'rails_helper'

RSpec.describe AssignCategoryAttributes, type: :mutation do
  describe '#execute' do
    let(:category) { Category.new }
    let(:attributes) { build(:category).attributes.slice('name', 'color', 'icon') }

    it 'assigns attributes to given category' do
      described_class.run!(category: category, attributes: attributes)
      expect(category.attributes.slice('name', 'color', 'icon')).to eq attributes
    end
  end
end
