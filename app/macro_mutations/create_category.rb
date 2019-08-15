class CreateCategory < Mutations::Command
  required do
    hash :category_attributes do
      required do
        string :name
        string :color, matches: Utils::Color::HEX_COLOR_REGEX
      end

      optional do
        string :icon
      end
    end
  end

  def execute
    build_new_category
    assign_category_attributes
    save_category
    @category
  end

  private def build_new_category
    @category = BuildNewCategory.run!
  end

  private def assign_category_attributes
    AssignCategoryAttributes.run!(category: @category, attributes: category_attributes)
  end

  private def save_category
    SaveCategory.run!(category: @category)
  end
end
