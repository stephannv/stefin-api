require 'rails_helper'

RSpec.describe DestroySubcategory, type: :mutation do
  describe '#execute' do
    let(:subcategory) { create(:subcategory) }

    context 'when subcategory can be destroyed' do
      it 'destroys subcategory' do
        described_class.run!(subcategory: subcategory)
        expect(subcategory).to be_destroyed
      end
    end
  end
end
