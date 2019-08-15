class FindCategory < Mutations::Command
  required do
    string :id
  end

  def execute
    Category.find(id)
  end
end
