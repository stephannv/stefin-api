class AssignSubcategoryAttributes < Mutations::Command
  required do
    model :subcategory, new_records: true
    hash :attributes do
      optional do
        string :category_id
        string :name, max_length: 32
        string :icon, max_length: 32
      end
    end
  end

  def execute
    subcategory.assign_attributes(attributes)
  end
end
