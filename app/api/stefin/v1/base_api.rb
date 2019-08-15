module Stefin
  module V1
    class BaseAPI < Grape::API
      version :v1, using: :path

      rescue_from ActiveRecord::RecordInvalid do |e|
        error!({ errors: e.record.errors.messages }, 422)
      end

      rescue_from ActiveRecord::RecordNotDestroyed do |e|
        error!({ errors: e.record.errors.messages }, 409)
      end

      rescue_from Grape::Exceptions::ValidationErrors do |e|
        errors_hash = e.map { |attr, msg| { attr.first => msg } }
        error!({ errors: errors_hash }, 400)
      end

      rescue_from ActiveRecord::RecordNotFound do |e|
        error!({ error: e.message }, 404)
      end

      rescue_from :all do |e|
        raise e.full_message if Rails.env.development?

        error!({ error: 'Internal server error' }, 500)
      end

      mount AccountsAPI
      mount CurrenciesAPI
      mount RecordsAPI
    end
  end
end
