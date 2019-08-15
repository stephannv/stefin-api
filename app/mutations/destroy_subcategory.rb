class DestroySubcategory < Mutations::Command
  required do
    model :subcategory
  end

  def execute
    subcategory.destroy!
  end
end
