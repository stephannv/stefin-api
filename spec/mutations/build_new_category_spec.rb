require 'rails_helper'

RSpec.describe BuildNewCategory, type: :mutation do
  describe '#execute' do
    let(:category) { described_class.run! }

    it 'builds a new category' do
      expect(described_class.run!).to be_a_new(Category)
    end
  end
end
