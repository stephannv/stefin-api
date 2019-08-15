require 'rails_helper'

RSpec.describe SaveSubcategory, type: :mutation do
  describe '#execute' do
    let(:subcategory) { build(:subcategory) }

    context 'when given attributes are valid' do
      it 'creates a new subcategory with given attributes' do
        expect(subcategory).to be_a_new(Subcategory)
        described_class.run!(subcategory: subcategory)
        expect(subcategory).to be_persisted
      end
    end

    context 'when given attributes are invalid' do
      it 'raises ActiveRecord::RecordInvalid error' do
        expect { described_class.run!(subcategory: Subcategory.new) }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end
end
