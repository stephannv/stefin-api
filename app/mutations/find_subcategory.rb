class FindSubcategory < Mutations::Command
  required do
    string :id
  end

  def execute
    Subcategory.find(id)
  end
end
