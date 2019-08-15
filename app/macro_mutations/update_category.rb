class UpdateCategory < Mutations::Command
  required do
    string :category_id

    hash :category_attributes do
      optional do
        string :name
        string :color, matches: Utils::Color::HEX_COLOR_REGEX
        string :icon
      end
    end
  end

  def execute
    find_category
    assign_category_attributes
    save_category
    @category
  end

  private def find_category
    @category = FindCategory.run!(id: category_id)
  end

  private def assign_category_attributes
    AssignCategoryAttributes.run!(category: @category, attributes: category_attributes)
  end

  private def save_category
    SaveCategory.run!(category: @category)
  end
end
