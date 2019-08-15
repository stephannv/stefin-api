require 'rails_helper'

RSpec.describe EraseSubcategory, type: :macro_mutation do
  describe '#execute' do
    let(:subcategory) { create(:subcategory) }

    it 'finds subcategory by id and destroys it' do
      described_class.run!(subcategory_id: subcategory.id)
      expect(Subcategory.find_by(id: subcategory.id)).to be_nil
    end
  end
end
