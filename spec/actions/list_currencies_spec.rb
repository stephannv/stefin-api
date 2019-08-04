require 'rails_helper'

RSpec.describe ListCurrencies, type: :action do
  describe 'Promises' do
    it 'promises :currencies' do
      expect(described_class.promises).to include :currencies
    end
  end

  describe 'Behavior' do
    let(:currency_a) { double(iso_code: 'AAA') }
    let(:currency_b) { double(iso_code: 'BBB') }

    before do
      allow(Money::Currency).to receive(:all).and_return([currency_b, currency_a])
    end

    it 'adds all currencies ordered by to context' do
      context = described_class.execute
      expect(context.currencies.first).to eq currency_a
      expect(context.currencies.last).to eq currency_b
    end
  end
end
