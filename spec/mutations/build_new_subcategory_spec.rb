require 'rails_helper'

RSpec.describe BuildNewSubcategory, type: :mutation do
  describe '#execute' do
    let(:subcategory) { described_class.run! }

    it 'builds a new subcategory' do
      expect(described_class.run!).to be_a_new(Subcategory)
    end
  end
end
