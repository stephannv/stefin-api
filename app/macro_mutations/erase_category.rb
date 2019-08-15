class EraseCategory < Mutations::Command
  required do
    string :category_id
  end

  def execute
    find_category
    destroy_category
  end

  private def find_category
    @category = FindCategory.run!(id: category_id)
  end

  private def destroy_category
    DestroyCategory.run!(category: @category)
  end
end
