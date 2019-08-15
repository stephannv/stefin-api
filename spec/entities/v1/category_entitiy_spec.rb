require 'rails_helper'

RSpec.describe V1::CategoryEntity, type: :entity do
  let(:resource) { build(:category, :with_id) }
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

    it 'exposes icon' do
      expect(serializable_hash[:icon]).to eq resource.icon
    end

    context 'when type isn`t detailed' do
      it 'doesn`t expose subcategories' do
        expect(serializable_hash[:subcategories]).to be_nil
      end
    end

    context 'when type is detailed' do
      let(:resource) { create(:category, :with_subcategories) }
      let(:serializable_hash) { described_class.new(resource, type: :detailed).serializable_hash }
      let(:subcategory) { resource.subcategories.first }
      let(:subcategory_serializable_hash) do
        V1::SubcategoryEntity.new(subcategory, except: [:category]).serializable_hash
      end

      it 'exposes subcategories' do
        expect(serializable_hash[:subcategories]).to eq [subcategory_serializable_hash]
      end
    end
  end
end
