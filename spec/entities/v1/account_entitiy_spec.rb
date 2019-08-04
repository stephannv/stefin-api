require 'rails_helper'

RSpec.describe V1::AccountEntity, type: :entity do
  let(:resource) { build(:account, :with_id) }
  let(:serializable_hash) { described_class.new(resource).serializable_hash }

  describe 'Exposures' do
    it 'exposes id' do
      expect(serializable_hash[:id]).to eq resource.id
    end

    it 'exposes name' do
      expect(serializable_hash[:name]).to eq resource.name
    end

    it 'exposes color' do
      expect(serializable_hash[:color]).to eq resource.color
    end

    it 'exposes balance' do
      expect(serializable_hash[:balance]).to eq resource.balance.to_d.to_s
    end

    it 'exposes balance_currency' do
      expect(serializable_hash[:balance_currency]).to eq resource.balance_currency
    end

    it 'exposes formatted_balance' do
      expect(serializable_hash[:formatted_balance]).to eq resource.balance.formatted
    end
  end
end
