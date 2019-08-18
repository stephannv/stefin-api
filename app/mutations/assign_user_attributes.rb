class AssignUserAttributes < Mutations::Command
  required do
    model :user, new_records: true
    hash :attributes do
      optional do
        string :name, max_length: 128
        string :email, max_length: 128
        string :password
        string :password_confirmation
      end
    end
  end

  def execute
    user.assign_attributes(attributes)
  end
end
