class FindRecord < Mutations::Command
  required do
    string :id
  end

  def execute
    Record.find(id)
  end
end
