module Stefin
  module V1
    class CurrenciesAPI < Grape::API
      # GET /v1/currencies
      desc 'List currencies'
      get '/currencies' do
        result = ::RetrieveCurrencies.call

        raise result.message if result.failure?

        present :currencies, result.currencies, with: ::V1::CurrencyEntity
      end
    end
  end
end
