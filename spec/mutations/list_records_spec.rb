require 'rails_helper'

RSpec.describe ListRecords, type: :mutation do
  describe '#execute' do
    let!(:records)  { create_list(:record, 3) }

    it 'returns all records' do
      expect(described_class.run!).to eq records
    end
  end
end
