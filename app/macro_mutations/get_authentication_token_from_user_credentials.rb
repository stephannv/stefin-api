class GetAuthenticationTokenFromUserCredentials < Mutations::Command
  required do
    hash :user_attributes do
      required do
        string :email
        string :password
      end
    end
  end

  def execute
    find_user_by_credentials
    generate_user_authentication_token if @user.present?
  end

  private def find_user_by_credentials
    @user = FindUserByCredentials.run!(user_attributes)
  end

  private def generate_user_authentication_token
    GenerateUserAuthenticationToken.run!(user: @user)
  end
end
