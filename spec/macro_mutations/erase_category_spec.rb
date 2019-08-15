require 'rails_helper'

RSpec.describe EraseCategory, type: :macro_mutation do
  describe '#execute' do
    let(:category) { create(:category) }

    it 'finds category by id and destroys it' do
      described_class.run!(category_id: category.id)
      expect(Category.find_by(id: category.id)).to be_nil
    end
  end
end
