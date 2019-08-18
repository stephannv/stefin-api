module Stefin
  module V1
    class AuthenticationsAPI < Grape::API
      # POST /v1/authentications
      desc 'Authenticate user'
      route_setting :auth, public: true
      params do
        requires :user, type: Hash do
          requires :email, type: String
          requires :password, type: String
        end
      end

      post '/authentications' do
        token = ::GetAuthenticationTokenFromUserCredentials.run!(user_attributes: params[:user])

        if token.present?
          present :token, token
        else
          error!({ message: 'Unauthorized' }, 401)
        end
      end
    end
  end
end
