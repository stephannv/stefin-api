require 'rails_helper'

RSpec.describe Stefin::V1::RecordsAPI, type: :api do
  mock_authenticate_request

  include_examples 'authenticate routes'

  describe 'GET /v1/records' do
    let(:record) { build(:record, :with_id) }

    before { allow(ListRecords).to receive(:run!).and_return([record]) }

    it 'has http status OK' do
      get '/v1/records'
      expect(response).to have_http_status(:ok)
    end

    it 'renders records' do
      get '/v1/records'
      expect(response.body).to eq({ records: [V1::RecordEntity.new(record)] }.to_json)
    end
  end

  describe 'GET /v1/records/:id' do
    let(:record) { build(:record, :with_id) }

    before { allow(FindRecord).to receive(:run!).with(id: record.id).and_return(record) }

    it 'has http status OK' do
      get '/v1/records'
      expect(response).to have_http_status(:ok)
    end

    it 'renders record' do
      get '/v1/records/' + record.id
      expect(response.body).to eq({ record: V1::RecordEntity.new(record, type: :detailed) }.to_json)
    end
  end

  describe 'POST /v1/records' do
    let(:record) { build(:record, :with_id) }
    let(:record_params) do
      {
        group: record.group,
        amount: record.amount.to_d,
        occurred_at: record.occurred_at,
        account_id: record.account_id,
        subcategory_id: record.subcategory_id
      }
    end

    before { allow(CreateRecord).to receive(:run!).with(record_attributes: record_params).and_return(record) }

    it 'has http status CREATED' do
      post '/v1/records', params: { record: record_params }
      expect(response).to have_http_status(:created)
    end

    it 'renders newly created record' do
      post '/v1/records', params: { record: record_params }
      expect(response.body).to eq({ record: V1::RecordEntity.new(record) }.to_json)
    end
  end

  describe 'PATCH /v1/records/:id' do
    let(:record) { build(:record, :with_id) }
    let(:record_params) { record.attributes.slice('occurred_at').symbolize_keys }

    before do
      allow(UpdateRecord).to receive(:run!)
        .with(record_id: record.id, record_attributes: record_params)
        .and_return(record)
    end

    it 'has http status OK' do
      patch "/v1/records/#{record.id}", params: { record: record_params }
      expect(response).to have_http_status(:ok)
    end

    it 'renders newly created record' do
      patch "/v1/records/#{record.id}", params: { record: record_params }
      expect(response.body).to eq({ record: V1::RecordEntity.new(record) }.to_json)
    end
  end

  describe 'DELETE /v1/records/:id' do
    let(:record_id) { 'some-id' }

    before do
      expect(EraseRecord).to receive(:run!).with(record_id: record_id)
    end

    it 'has http status NO_CONTENT' do
      delete "/v1/records/#{record_id}"
      expect(response).to have_http_status(:no_content)
    end
  end
end
