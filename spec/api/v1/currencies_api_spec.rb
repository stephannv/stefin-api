require 'rails_helper'

RSpec.describe Stefin::V1::CurrenciesAPI do
  describe 'GET /v1/currencies' do
    context 'when currencies retrieving is successfull' do
      let(:currency) { Money::Currency.first }
      let(:result) { double(failure?: false, currencies: [currency]) }

      before { allow(RetrieveCurrencies).to receive(:call).and_return(result) }

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
end
