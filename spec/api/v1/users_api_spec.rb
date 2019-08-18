require 'rails_helper'

RSpec.describe Stefin::V1::UsersAPI, type: :api do
  mock_authenticate_request

  include_examples 'authenticate routes', public_paths: ['POST /v1/users']

  describe 'POST /v1/users' do
    let(:user) { build(:user, :with_id) }
    let(:user_params) { attributes_for(:user) }

    before do
      allow(CreateUser).to receive(:run!)
        .with(user_attributes: user_params)
        .and_return(user)
    end

    it 'has http status CREATED' do
      post '/v1/users', params: { user: user_params }
      expect(response).to have_http_status(:created)
    end

    it 'renders newly created user' do
      post '/v1/users', params: { user: user_params }
      expect(response.body).to eq({ user: V1::UserEntity.new(user) }.to_json)
    end
  end
end
