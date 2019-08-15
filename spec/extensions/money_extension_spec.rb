require 'rails_helper'

RSpec.describe Extensions::MoneyExtension, type: :extensions do
  describe '#formatted' do
    it 'concatenates currency code and value' do
      money = Money.new(1000, 'BRL')
      expect(money.formatted).to eq 'BRL 10,00'
    end
  end
end
