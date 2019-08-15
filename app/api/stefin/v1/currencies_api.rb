module Stefin
  module V1
    class CurrenciesAPI < Grape::API
      # GET /v1/currencies
      desc 'List currencies'
      get '/currencies' do
        currencies = ::ListCurrencies.run!

        present :currencies, currencies, with: ::V1::CurrencyEntity
      end
    end
  end
end
