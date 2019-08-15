class ListCategories < Mutations::Command
  def execute
    Category.all
  end
end
