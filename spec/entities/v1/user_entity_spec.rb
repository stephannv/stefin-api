require 'rails_helper'

RSpec.describe V1::UserEntity, type: :entity do
  let(:resource) { build(:user, :with_id) }
  let(:serializable_hash) { described_class.new(resource).serializable_hash }

  describe 'Exposures' do
    it 'exposes id' do
      expect(serializable_hash[:id]).to eq resource.id
    end

    it 'exposes name' do
      expect(serializable_hash[:name]).to eq resource.name
    end

    it 'exposes email' do
      expect(serializable_hash[:email]).to eq resource.email
    end
  end
end
