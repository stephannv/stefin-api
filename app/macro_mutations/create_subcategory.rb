class CreateSubcategory < Mutations::Command
  required do
    hash :subcategory_attributes do
      required do
        string :category_id
        string :name
      end

      optional do
        string :icon
      end
    end
  end

  def execute
    build_new_subcategory
    assign_subcategory_attributes
    save_subcategory
    @subcategory
  end

  private def build_new_subcategory
    @subcategory = BuildNewSubcategory.run!
  end

  private def assign_subcategory_attributes
    AssignSubcategoryAttributes.run!(subcategory: @subcategory, attributes: subcategory_attributes)
  end

  private def save_subcategory
    SaveSubcategory.run!(subcategory: @subcategory)
  end
end
