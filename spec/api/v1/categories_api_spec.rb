require 'rails_helper'

RSpec.describe Stefin::V1::CategoriesAPI, type: :api do
  mock_authenticate_request

  include_examples 'authenticate routes'

  describe 'GET /v1/categories' do
    let(:category) { build(:category, :with_id) }

    before { allow(ListCategories).to receive(:run!).and_return([category]) }

    it 'has http status OK' do
      get '/v1/categories'
      expect(response).to have_http_status(:ok)
    end

    it 'renders categories' do
      get '/v1/categories'
      expect(response.body).to eq({ categories: [V1::CategoryEntity.new(category)] }.to_json)
    end
  end

  describe 'GET /v1/categories/:id' do
    let(:category) { build(:category, :with_id) }

    before { allow(FindCategory).to receive(:run!).with(id: category.id).and_return(category) }

    it 'has http status OK' do
      get '/v1/categories'
      expect(response).to have_http_status(:ok)
    end

    it 'renders category' do
      get '/v1/categories/' + category.id
      expect(response.body).to eq({ category: V1::CategoryEntity.new(category, type: :detailed) }.to_json)
    end
  end

  describe 'POST /v1/categories' do
    let(:category) { build(:category, :with_id) }
    let(:category_params) { category.attributes.slice('name', 'color', 'icon').symbolize_keys }

    before { allow(CreateCategory).to receive(:run!).with(category_attributes: category_params).and_return(category) }

    it 'has http status CREATED' do
      post '/v1/categories', params: { category: category_params }
      expect(response).to have_http_status(:created)
    end

    it 'renders newly created category' do
      post '/v1/categories', params: { category: category_params }
      expect(response.body).to eq({ category: V1::CategoryEntity.new(category) }.to_json)
    end
  end

  describe 'PATCH /v1/categories/:id' do
    let(:category) { build(:category, :with_id) }
    let(:category_params) { category.attributes.slice('name').symbolize_keys }

    before do
      allow(UpdateCategory).to receive(:run!)
        .with(category_id: category.id, category_attributes: category_params)
        .and_return(category)
    end

    it 'has http status OK' do
      patch "/v1/categories/#{category.id}", params: { category: category_params }
      expect(response).to have_http_status(:ok)
    end

    it 'renders newly created category' do
      patch "/v1/categories/#{category.id}", params: { category: category_params }
      expect(response.body).to eq({ category: V1::CategoryEntity.new(category) }.to_json)
    end
  end

  describe 'DELETE /v1/categories/:id' do
    let(:category_id) { 'some-id' }

    before do
      expect(EraseCategory).to receive(:run!).with(category_id: category_id)
    end

    it 'has http status NO_CONTENT' do
      delete "/v1/categories/#{category_id}"
      expect(response).to have_http_status(:no_content)
    end
  end
end
