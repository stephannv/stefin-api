require 'rails_helper'

RSpec.describe V1::RecordEntity, type: :entity do
  let(:resource) { build(:record, :with_id) }
  let(:serializable_hash) { described_class.new(resource).serializable_hash }

  describe 'Exposures' do
    it 'exposes id' do
      expect(serializable_hash[:id]).to eq resource.id
    end

    it 'exposes occurred_at' do
      expect(serializable_hash[:occurred_at]).to eq resource.occurred_at
    end

    it 'exposes group' do
      expect(serializable_hash[:group]).to eq resource.group
    end

    it 'exposes title' do
      expect(serializable_hash[:title]).to eq resource.title
    end

    it 'exposes description' do
      expect(serializable_hash[:description]).to eq resource.description
    end

    it 'exposes account' do
      expect(serializable_hash[:account]).to eq V1::AccountEntity.new(resource.account).serializable_hash
    end

    it 'exposes amount' do
      expect(serializable_hash[:amount]).to eq resource.amount.to_d.to_s
    end

    it 'exposes amount_currency' do
      expect(serializable_hash[:amount_currency]).to eq resource.amount_currency
    end

    it 'exposes formatted_amount' do
      expect(serializable_hash[:formatted_amount]).to eq resource.amount.formatted
    end
  end
end
