class ListSubcategories < Mutations::Command
  def execute
    Subcategory.all
  end
end
