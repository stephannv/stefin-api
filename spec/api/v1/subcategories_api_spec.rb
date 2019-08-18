require 'rails_helper'

RSpec.describe Stefin::V1::SubcategoriesAPI, type: :api do
  mock_authenticate_request

  include_examples 'authenticate routes'

  describe 'GET /v1/subcategories' do
    let(:subcategory) { build(:subcategory, :with_id) }

    before { allow(ListSubcategories).to receive(:run!).and_return([subcategory]) }

    it 'has http status OK' do
      get '/v1/subcategories'
      expect(response).to have_http_status(:ok)
    end

    it 'renders subcategories' do
      get '/v1/subcategories'
      expect(response.body).to eq({ subcategories: [V1::SubcategoryEntity.new(subcategory)] }.to_json)
    end
  end

  describe 'GET /v1/subcategories/:id' do
    let(:subcategory) { build(:subcategory, :with_id) }

    before { allow(FindSubcategory).to receive(:run!).with(id: subcategory.id).and_return(subcategory) }

    it 'has http status OK' do
      get '/v1/subcategories'
      expect(response).to have_http_status(:ok)
    end

    it 'renders subcategory' do
      get '/v1/subcategories/' + subcategory.id
      expect(response.body).to eq({ subcategory: V1::SubcategoryEntity.new(subcategory) }.to_json)
    end
  end

  describe 'POST /v1/subcategories' do
    let(:subcategory) { build(:subcategory, :with_id) }
    let(:subcategory_params) { subcategory.attributes.slice('category_id', 'name', 'icon').symbolize_keys }

    before do
      allow(CreateSubcategory).to receive(:run!)
        .with(subcategory_attributes: subcategory_params)
        .and_return(subcategory)
    end

    it 'has http status CREATED' do
      post '/v1/subcategories', params: { subcategory: subcategory_params }
      expect(response).to have_http_status(:created)
    end

    it 'renders newly created subcategory' do
      post '/v1/subcategories', params: { subcategory: subcategory_params }
      expect(response.body).to eq({ subcategory: V1::SubcategoryEntity.new(subcategory) }.to_json)
    end
  end

  describe 'PATCH /v1/subcategories/:id' do
    let(:subcategory) { build(:subcategory, :with_id) }
    let(:subcategory_params) { subcategory.attributes.slice('name').symbolize_keys }

    before do
      allow(UpdateSubcategory).to receive(:run!)
        .with(subcategory_id: subcategory.id, subcategory_attributes: subcategory_params)
        .and_return(subcategory)
    end

    it 'has http status OK' do
      patch "/v1/subcategories/#{subcategory.id}", params: { subcategory: subcategory_params }
      expect(response).to have_http_status(:ok)
    end

    it 'renders newly created subcategory' do
      patch "/v1/subcategories/#{subcategory.id}", params: { subcategory: subcategory_params }
      expect(response.body).to eq({ subcategory: V1::SubcategoryEntity.new(subcategory) }.to_json)
    end
  end

  describe 'DELETE /v1/subcategories/:id' do
    let(:subcategory_id) { 'some-id' }

    before do
      expect(EraseSubcategory).to receive(:run!).with(subcategory_id: subcategory_id)
    end

    it 'has http status NO_CONTENT' do
      delete "/v1/subcategories/#{subcategory_id}"
      expect(response).to have_http_status(:no_content)
    end
  end
end
