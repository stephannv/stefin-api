class CreateUser < Mutations::Command
  required do
    hash :user_attributes do
      required do
        string :name
        string :email
        string :password
        string :password_confirmation
      end
    end
  end

  def execute
    build_new_user
    assign_user_attributes
    save_user
    @user
  end

  private def build_new_user
    @user = BuildNewUser.run!
  end

  private def assign_user_attributes
    AssignUserAttributes.run!(user: @user, attributes: user_attributes)
  end

  private def save_user
    SaveUser.run!(user: @user)
  end
end
