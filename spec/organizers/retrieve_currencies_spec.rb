require 'rails_helper'

RSpec.describe RetrieveCurrencies, type: :organizer do
  describe 'Behaviors' do
    let(:currencies) { Money::Currency.all.sort_by(&:iso_code) }
    let(:result) { described_class.call }

    it 'is successfull' do
      expect(result).to be_success
    end

    it 'returns all currencies ordered by ISO code' do
      expect(result.currencies).to eq currencies
    end
  end
end
