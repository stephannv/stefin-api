require 'rails_helper'

RSpec.describe Stefin::V1::BaseAPI do
  describe 'Configuration' do
    it 'has json format' do
      expect(described_class.format).to eq :json
    end

    it 'has v1 as version' do
      expect(described_class.version).to eq :v1
    end
  end

  describe 'Mounted apps' do
    let(:base_routes) { described_class.routes.map(&:path) }

    it 'mounts Stefin::V1::CurrenciesAPI app' do
      Stefin::V1::CurrenciesAPI.routes.each do |route|
        expect(base_routes).to include(route.path)
      end
    end

    it 'mounts Stefin::V1::AccountsAPI app' do
      Stefin::V1::AccountsAPI.routes.each do |route|
        expect(base_routes).to include(route.path)
      end
    end
  end

  describe 'Rescued errors' do
    subject { Class.new(Stefin::V1::BaseAPI) }

    def app
      subject
    end

    context 'when Grape::Exceptions::ValidationErrors is raised' do
      before do
        subject.params do
          requires :required_param, type: String
        end

        subject.get '/example' do
          raise Grape::Exceptions::ValidationErrors
        end
      end

      it 'formats params errors as json' do
        get '/v1/example'
        expect(response.body).to eq({ errors: [{ required_param: 'is missing' }] }.to_json)
      end

      it 'responds with 400 http code' do
        get '/v1/example'
        expect(response).to have_http_status(:bad_request)
      end
    end

    context 'when ActiveRecord::RecordNotFound is raised' do
      before do
        subject.get '/example' do
          raise ActiveRecord::RecordNotFound, 'not found'
        end
      end

      it 'format error as json' do
        get '/v1/example'
        expect(response.body).to eq({ error: 'not found' }.to_json)
      end

      it 'responds with 404 http code' do
        get '/v1/example'
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'when an unexpected exception is raised' do
      before do
        subject.get '/example' do
          raise 'Some error'
        end
      end

      it 'format error as json' do
        get '/v1/example'
        expect(response.body).to eq({ error: 'Internal server error' }.to_json)
      end

      it 'responds with 500 http code' do
        get '/v1/example'
        expect(response).to have_http_status(:server_error)
      end
    end
  end
end
