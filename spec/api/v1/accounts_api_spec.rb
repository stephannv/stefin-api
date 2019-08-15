require 'rails_helper'

RSpec.describe Stefin::V1::AccountsAPI do
  describe 'GET /v1/accounts' do
    let(:account) { build(:account, :with_id) }

    before { allow(ListAccounts).to receive(:run!).and_return([account]) }

    it 'has http status OK' do
      get '/v1/accounts'
      expect(response).to have_http_status(:ok)
    end

    it 'renders accounts' do
      get '/v1/accounts'
      expect(response.body).to eq({ accounts: [V1::AccountEntity.new(account)] }.to_json)
    end
  end

  describe 'GET /v1/accounts/:id' do
    let(:account) { build(:account, :with_id) }

    before { allow(FindAccount).to receive(:run!).with(id: account.id).and_return(account) }

    it 'has http status OK' do
      get '/v1/accounts'
      expect(response).to have_http_status(:ok)
    end

    it 'renders account' do
      get '/v1/accounts/' + account.id
      expect(response.body).to eq({ account: V1::AccountEntity.new(account, type: :detailed) }.to_json)
    end
  end

  describe 'POST /v1/accounts' do
    let(:account) { build(:account, :with_id) }
    let(:account_params) { account.attributes.slice('name', 'color', 'balance_currency').symbolize_keys }

    before { allow(CreateAccount).to receive(:run!).with(account_attributes: account_params).and_return(account) }

    it 'has http status CREATED' do
      post '/v1/accounts', params: { account: account_params }
      expect(response).to have_http_status(:created)
    end

    it 'renders newly created account' do
      post '/v1/accounts', params: { account: account_params }
      expect(response.body).to eq({ account: V1::AccountEntity.new(account) }.to_json)
    end
  end

  describe 'PATCH /v1/accounts/:id' do
    let(:account) { build(:account, :with_id) }
    let(:account_params) { account.attributes.slice('name').symbolize_keys }

    before do
      allow(UpdateAccount).to receive(:run!)
        .with(account_id: account.id, account_attributes: account_params)
        .and_return(account)
    end

    it 'has http status OK' do
      patch "/v1/accounts/#{account.id}", params: { account: account_params }
      expect(response).to have_http_status(:ok)
    end

    it 'renders newly created account' do
      patch "/v1/accounts/#{account.id}", params: { account: account_params }
      expect(response.body).to eq({ account: V1::AccountEntity.new(account) }.to_json)
    end
  end

  describe 'DELETE /v1/accounts/:id' do
    let(:account_id) { 'some-id' }

    before do
      expect(EraseAccount).to receive(:run!).with(account_id: account_id)
    end

    it 'has http status NO_CONTENT' do
      delete "/v1/accounts/#{account_id}"
      expect(response).to have_http_status(:no_content)
    end
  end
end
