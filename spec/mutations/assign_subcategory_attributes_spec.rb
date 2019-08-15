require 'rails_helper'

RSpec.describe AssignSubcategoryAttributes, type: :mutation do
  describe '#execute' do
    let(:subcategory) { Subcategory.new }
    let(:attributes) { build(:subcategory).attributes.slice('name', 'category_id', 'icon') }

    it 'assigns attributes to given subcategory' do
      described_class.run!(subcategory: subcategory, attributes: attributes)
      expect(subcategory.attributes.slice('name', 'category_id', 'icon')).to eq attributes
    end
  end
end
