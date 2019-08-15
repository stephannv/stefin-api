require 'rails_helper'

RSpec.describe SaveCategory, type: :mutation do
  describe '#execute' do
    let(:category) { build(:category) }

    context 'when given attributes are valid' do
      it 'creates a new category with given attributes' do
        expect(category).to be_a_new(Category)
        described_class.run!(category: category)
        expect(category).to be_persisted
      end
    end

    context 'when given attributes are invalid' do
      it 'raises ActiveRecord::RecordInvalid error' do
        expect { described_class.run!(category: Category.new) }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end
end
