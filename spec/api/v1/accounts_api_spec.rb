require 'rails_helper'

RSpec.describe Stefin::V1::CurrenciesAPI do
  describe 'GET /v1/accounts' do
    before { allow(RetrieveAccounts).to receive(:call).and_return(result) }

    context 'when accounts retrieving is successfull' do
      let(:account) { build(:account, :with_id) }
      let(:result) { double(failure?: false, accounts: [account]) }

      it 'has http status OK' do
        get '/v1/accounts'
        expect(response).to have_http_status(:ok)
      end

      it 'renders accounts' do
        get '/v1/accounts'
        expect(response.body).to eq({ accounts: [V1::AccountEntity.new(account)] }.to_json)
      end
    end

    context 'when accounts retrieving fails' do
      let(:result) { double(failure?: true, message: Faker::Lorem.word) }

      it 'raises error' do
        get '/v1/accounts'
        expect(response).to have_http_status(:internal_server_error)
      end
    end
  end

  describe 'GET /v1/accounts/:id' do
    let(:account) { build(:account, :with_id) }

    before { allow(RetrieveAccount).to receive(:call).with(account_id: account.id).and_return(result) }

    context 'when account retrieving is successullf' do
      let(:result) { double(failure?: false, account: account) }

      it 'has http status OK' do
        get '/v1/accounts'
        expect(response).to have_http_status(:ok)
      end

      it 'renders account' do
        get '/v1/accounts/' + account.id
        expect(response.body).to eq({ account: V1::AccountEntity.new(account, type: :detailed) }.to_json)
      end
    end

    context 'when account retrieving fails' do
      let(:result) { double(failure?: true, message: Faker::Lorem.word) }

      it 'raises error' do
        get '/v1/accounts/' + account.id
        expect(response).to have_http_status(:internal_server_error)
      end
    end
  end

  describe 'POST /v1/accounts' do
    let(:account_params) { attributes_for(:account).slice(:name, :color, :balance_currency) }

    before { allow(CreateAccount).to receive(:call).with(account_attributes: account_params).and_return(result) }

    context 'when account creation is successfull' do
      let(:result) { double(success?: true, account: build(:account, :with_id)) }

      it 'has http status CREATED' do
        post '/v1/accounts', params: { account: account_params }
        expect(response).to have_http_status(:created)
      end

      it 'renders newly created account' do
        post '/v1/accounts', params: { account: account_params }
        expect(response.body).to eq({ account: V1::AccountEntity.new(result.account) }.to_json)
      end
    end

    context 'when account creation fails' do
      let(:errors) { double(messages: { field: ['error'] }) }
      let(:result) { double(success?: false, account: double(errors: errors)) }

      it 'has http status UNPROCESSABLE_ENTITY' do
        post '/v1/accounts', params: { account: account_params }
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'renders account errors' do
        post '/v1/accounts', params: { account: account_params }
        expect(response.body).to eq({ errors: errors.messages }.to_json)
      end
    end
  end

  describe 'PATCH /v1/accounts/:id' do
    let(:account_id) { 'some-id' }
    let(:account_params) { attributes_for(:account).slice(:name) }

    before do
      allow(UpdateAccount).to receive(:call)
        .with(account_id: account_id, account_attributes: account_params)
        .and_return(result)
    end

    context 'when account update is successfull' do
      let(:result) { double(success?: true, account: build(:account, :with_id)) }

      it 'has http status OK' do
        patch "/v1/accounts/#{account_id}", params: { account: account_params }
        expect(response).to have_http_status(:ok)
      end

      it 'renders newly created account' do
        patch "/v1/accounts/#{account_id}", params: { account: account_params }
        expect(response.body).to eq({ account: V1::AccountEntity.new(result.account) }.to_json)
      end
    end

    context 'when account update fails' do
      let(:errors) { double(messages: { field: ['error'] }) }
      let(:result) { double(success?: false, account: double(errors: errors)) }

      it 'has http status UNPROCESSABLE_ENTITY' do
        patch "/v1/accounts/#{account_id}", params: { account: account_params }
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'renders account errors' do
        patch "/v1/accounts/#{account_id}", params: { account: account_params }
        expect(response.body).to eq({ errors: errors.messages }.to_json)
      end
    end
  end

  describe 'DELETE /v1/accounts/:id' do
    let(:account_id) { 'some-id' }

    before do
      allow(EraseAccount).to receive(:call).with(account_id: account_id).and_return(result)
    end

    context 'when account destruction is successfull' do
      let(:result) { double(success?: true) }

      it 'has http status NO_CONTENT' do
        delete "/v1/accounts/#{account_id}"
        expect(response).to have_http_status(:no_content)
      end
    end

    context 'when account destruction fails' do
      let(:errors) { double(messages: { field: ['error'] }) }
      let(:result) { double(success?: false, account: double(errors: errors)) }

      it 'has http status CONFLICT' do
        delete "/v1/accounts/#{account_id}"
        expect(response).to have_http_status(:conflict)
      end

      it 'renders account errors' do
        delete "/v1/accounts/#{account_id}"
        expect(response.body).to eq({ errors: errors.messages }.to_json)
      end
    end
  end
end
