module Stefin
  module V1
    class AccountsAPI < Grape::API
      helpers do
        def account_params
          declared(params, include_missing: false)[:account].symbolize_keys
        end
      end

      # GET /v1/accounts
      desc 'List accounts'
      get '/accounts' do
        accounts = ::ListAccounts.run!

        present :accounts, accounts, with: ::V1::AccountEntity
      end

      # GET /v1/accounts/:id
      desc 'Show account details'
      params do
        requires :id, type: String
      end

      get '/accounts/:id' do
        account = ::FindAccount.run!(id: params[:id])

        present :account, account, with: ::V1::AccountEntity, type: :detailed
      end

      # POST /v1/accounts
      desc 'Create a new account'
      params do
        requires :account, type: Hash do
          requires :name, type: String
          requires :color, type: String
          requires :balance_currency, type: String, values: Money::Currency.to_a.map(&:iso_code)
        end
      end

      post '/accounts' do
        account = ::CreateAccount.run!(account_attributes: account_params)

        present :account, account, with: ::V1::AccountEntity
      end

      # PUT /v1/accounts/:id
      desc 'Update an account'
      params do
        requires :id, type: String
        requires :account, type: Hash do
          optional :name, type: String
          optional :color, type: String
          at_least_one_of :name, :color
        end
      end

      patch '/accounts/:id' do
        account = ::UpdateAccount.run!(account_id: params[:id], account_attributes: account_params)

        present :account, account, with: ::V1::AccountEntity
      end

      # DELETE /v1/accounts/:id
      desc 'Destroy an account'
      params do
        requires :id, type: String
      end

      delete '/accounts/:id' do
        ::EraseAccount.run!(account_id: params[:id])
        status :no_content
      end
    end
  end
end
