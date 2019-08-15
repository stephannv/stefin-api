module Stefin
  module V1
    class RecordsAPI < Grape::API
      helpers do
        def record_params
          declared(params, include_missing: false)[:record].symbolize_keys
        end
      end

      # GET /v1/records
      desc 'List records'
      get '/records' do
        records = ::ListRecords.run!

        present :records, records, with: ::V1::RecordEntity
      end

      # GET /v1/records/:id
      desc 'Show record details'
      params do
        requires :id, type: String
      end

      get '/records/:id' do
        record = ::FindRecord.run!(id: params[:id])

        present :record, record, with: ::V1::RecordEntity, type: :detailed
      end

      # POST /v1/records
      desc 'Create a new record'
      params do
        requires :record, type: Hash do
          requires :group, type: Symbol, values: %i[expense income]
          requires :account_id, type: String
          requires :subcategory_id, type: String
          requires :occurred_at, type: DateTime
          requires :amount, type: BigDecimal
          optional :title, type: String
          optional :description, type: String
        end
      end

      post '/records' do
        record = ::CreateRecord.run!(record_attributes: record_params)

        present :record, record, with: ::V1::RecordEntity
      end

      # PUT /v1/records/:id
      desc 'Update a record'
      params do
        requires :id, type: String
        requires :record, type: Hash do
          optional :group, type: Symbol, values: %i[expense income]
          optional :subcategory_id, type: String
          optional :occurred_at, type: DateTime
          optional :amount, type: BigDecimal
          optional :title, type: String
          optional :description, type: String
          at_least_one_of :group, :subcategory_id, :occurred_at, :amount, :title, :description
        end
      end

      patch '/records/:id' do
        record = ::UpdateRecord.run!(record_id: params[:id], record_attributes: record_params)

        present :record, record, with: ::V1::RecordEntity
      end

      # DELETE /v1/records/:id
      desc 'Destroy a record'
      params do
        requires :id, type: String
      end

      delete '/records/:id' do
        EraseRecord.run!(record_id: params[:id])
        status :no_content
      end
    end
  end
end
