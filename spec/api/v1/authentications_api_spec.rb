require 'rails_helper'

RSpec.describe Stefin::V1::AuthenticationsAPI, type: :api do
  mock_authenticate_request

  include_examples 'authenticate routes', public_paths: ['POST /v1/authentications']

  describe 'POST /v1/authentications' do
    let(:token) { Faker::Lorem.word }
    let(:user_params) { attributes_for(:user).slice(:email, :password) }

    context 'when authentication is successfull' do
      before do
        allow(GetAuthenticationTokenFromUserCredentials).to receive(:run!)
          .with(user_attributes: user_params)
          .and_return(token)
      end

      it 'has http status CREATED' do
        post '/v1/authentications', params: { user: user_params }
        expect(response).to have_http_status(:created)
      end

      it 'renders authentication token' do
        post '/v1/authentications', params: { user: user_params }
        expect(response.body).to eq({ token: token }.to_json)
      end
    end

    context 'when authentication fails' do
      before do
        allow(GetAuthenticationTokenFromUserCredentials).to receive(:run!)
          .with(user_attributes: user_params)
          .and_return(nil)
      end

      it 'has http status UNAUTHORIZED' do
        post '/v1/authentications', params: { user: user_params }
        expect(response).to have_http_status(:unauthorized)
      end

      it 'renders unauthorized message' do
        post '/v1/authentications', params: { user: user_params }
        expect(response.body).to eq({ message: 'Unauthorized' }.to_json)
      end
    end
  end
end
