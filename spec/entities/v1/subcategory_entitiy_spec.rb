require 'rails_helper'

RSpec.describe V1::SubcategoryEntity, type: :entity do
  let(:resource) { build(:subcategory, :with_id) }
  let(:serializable_hash) { described_class.new(resource).serializable_hash }

  describe 'Exposures' do
    it 'exposes id' do
      expect(serializable_hash[:id]).to eq resource.id
    end

    it 'exposes name' do
      expect(serializable_hash[:name]).to eq resource.name
    end

    it 'exposes icon' do
      expect(serializable_hash[:icon]).to eq resource.icon
    end

    it 'exposes category' do
      category_hash = V1::CategoryEntity.represent(resource.category, except: [:subcategories]).serializable_hash
      expect(serializable_hash[:category]).to eq category_hash
    end
  end
end
