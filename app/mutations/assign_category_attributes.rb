class AssignCategoryAttributes < Mutations::Command
  required do
    model :category, new_records: true
    hash :attributes do
      optional do
        string :name, max_length: 32
        string :color, matches: Utils::Color::HEX_COLOR_REGEX
        string :icon, max_length: 32
      end
    end
  end

  def execute
    category.assign_attributes(attributes)
  end
end
