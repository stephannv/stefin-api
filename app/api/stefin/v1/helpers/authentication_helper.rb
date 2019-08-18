module Stefin
  module V1
    module Helpers
      module AuthenticationHelper
        def authenticate_request!
          return if public_route?

          error!({ message: 'Unauthorized' }, 401) if current_user.nil?
        end

        def public_route?
          route.settings.dig(:auth, :public)
        end

        def current_user
          return if headers['Authorization'].blank?

          @current_user ||= ::GetUserFromAuthenticationToken.run!(authorization_header: headers['Authorization'])
        end
      end
    end
  end
end
