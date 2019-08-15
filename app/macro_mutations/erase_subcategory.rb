class EraseSubcategory < Mutations::Command
  required do
    string :subcategory_id
  end

  def execute
    find_subcategory
    destroy_subcategory
  end

  private def find_subcategory
    @subcategory = FindSubcategory.run!(id: subcategory_id)
  end

  private def destroy_subcategory
    DestroySubcategory.run!(subcategory: @subcategory)
  end
end
