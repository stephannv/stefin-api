class FindAccount < Mutations::Command
  required do
    string :id
  end

  def execute
    Account.find(id)
  end
end
