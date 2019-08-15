require 'rails_helper'

RSpec.describe CaptureRecordChanges, type: :mutation do
  describe '#execute' do
    let(:record) { create(:record) }
    let!(:old_title) { record.title }
    let(:new_title) { "New #{Faker::Lorem.word}" }

    before { record.title = new_title }

    it 'returns record changes' do
      expect(described_class.run!(record: record)).to eq('title' => [old_title, new_title])
    end
  end
end
