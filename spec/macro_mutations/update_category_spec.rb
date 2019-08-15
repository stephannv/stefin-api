require 'rails_helper'

RSpec.describe UpdateCategory, type: :macro_mutation do
  describe '#execute' do
    let(:category) { create(:category) }
    let(:new_name) { Faker::Lorem.word }

    it 'updates an category with given attributes' do
      described_class.run!(category_id: category.id, category_attributes: { name: new_name })
      expect(category.reload.name).to eq new_name
    end
  end
end
