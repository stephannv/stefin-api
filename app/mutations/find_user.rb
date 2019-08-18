class FindUser < Mutations::Command
  required do
    string :id
  end

  def execute
    User.find(id)
  end
end
