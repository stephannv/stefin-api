class UpdateSubcategory < Mutations::Command
  required do
    string :subcategory_id

    hash :subcategory_attributes do
      optional do
        string :category_id
        string :name
        string :color, matches: Utils::Color::HEX_COLOR_REGEX
      end
    end
  end

  def execute
    find_subcategory
    assign_subcategory_attributes
    save_subcategory
    @subcategory
  end

  private def find_subcategory
    @subcategory = FindSubcategory.run!(id: subcategory_id)
  end

  private def assign_subcategory_attributes
    AssignSubcategoryAttributes.run!(subcategory: @subcategory, attributes: subcategory_attributes)
  end

  private def save_subcategory
    SaveSubcategory.run!(subcategory: @subcategory)
  end
end
