require 'rails_helper'

RSpec.describe Stefin::V1::CurrenciesAPI, type: :api do
  mock_authenticate_request

  include_examples 'authenticate routes'

  describe 'GET /v1/currencies' do
    let(:currency) { Money::Currency.first }

    before { allow(ListCurrencies).to receive(:run!).and_return([currency]) }

    it 'has http status OK' do
      get '/v1/currencies'
      expect(response).to have_http_status(:ok)
    end

    it 'renders currencies' do
      get '/v1/currencies'
      expect(response.body).to eq({ currencies: [V1::CurrencyEntity.new(currency)] }.to_json)
    end
  end
end
