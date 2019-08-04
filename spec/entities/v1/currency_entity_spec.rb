require 'rails_helper'

RSpec.describe V1::CurrencyEntity, type: :entity do
  let(:resource) { Money::Currency.to_a.sample }
  let(:serializable_hash) { described_class.new(resource).serializable_hash }

  describe 'Exposures' do
    it 'exposes code' do
      expect(serializable_hash[:code]).to eq resource.code
    end

    it 'exposes name' do
      expect(serializable_hash[:name]).to eq resource.name
    end
  end
end
