require 'rails_helper'

RSpec.describe UpdateSubcategory, type: :macro_mutation do
  describe '#execute' do
    let(:subcategory) { create(:subcategory) }
    let(:new_name) { Faker::Lorem.word }

    it 'updates an subcategory with given attributes' do
      described_class.run!(subcategory_id: subcategory.id, subcategory_attributes: { name: new_name })
      expect(subcategory.reload.name).to eq new_name
    end
  end
end
