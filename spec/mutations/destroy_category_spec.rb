require 'rails_helper'

RSpec.describe DestroyCategory, type: :mutation do
  describe '#execute' do
    let(:category) { create(:category) }

    context 'when category can be destroyed' do
      it 'destroys category' do
        described_class.run!(category: category)
        expect(category).to be_destroyed
      end
    end
  end
end
