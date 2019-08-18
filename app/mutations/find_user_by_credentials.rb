class FindUserByCredentials < Mutations::Command
  required do
    string :email
    string :password
  end

  def execute
    User.find_by(email: email).try(:authenticate, password)
  end
end
