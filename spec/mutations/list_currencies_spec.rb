require 'rails_helper'

RSpec.describe ListCurrencies, type: :mutation do
  describe '#execute' do
    let!(:currencies) { Money::Currency.all.sort_by(&:iso_code) }

    it 'returns all accounts' do
      expect(described_class.run!).to eq currencies
    end
  end
end
