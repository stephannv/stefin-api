class SaveSubcategory < Mutations::Command
  required do
    model :subcategory, new_records: true
  end

  def execute
    subcategory.save!
  end
end
