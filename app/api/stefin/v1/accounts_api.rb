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
        result = ::RetrieveAccounts.call

        raise result.message if result.failure?

        present :accounts, result.accounts, with: ::V1::AccountEntity
      end

      # GET /v1/accounts/:id
      desc 'Show account details'

      params do
        requires :id, type: String
      end

      get '/accounts/:id' do
        result = ::RetrieveAccount.call(account_id: params[:id])

        raise result.message if result.failure?

        present :account, result.account, with: ::V1::AccountEntity, type: :detailed
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
        result = ::CreateAccount.call(account_attributes: account_params)

        if result.success?
          present :account, result.account, with: ::V1::AccountEntity
        else
          error!({ errors: result.account.errors.messages }, :unprocessable_entity)
        end
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
        result = ::UpdateAccount.call(account_id: params[:id], account_attributes: account_params)

        if result.success?
          present :account, result.account, with: ::V1::AccountEntity
        else
          error!({ errors: result.account.errors.messages }, :unprocessable_entity)
        end
      end

      # DELETE /v1/accounts/:id
      desc 'Destroy an account'

      params do
        requires :id, type: String
      end

      delete '/accounts/:id' do
        result = ::EraseAccount.call(account_id: params[:id])

        if result.success?
          status :no_content
        else
          error!({ errors: result.account.errors.messages }, :conflict)
        end
      end
    end
  end
end
