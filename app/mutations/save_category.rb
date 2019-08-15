class SaveCategory < Mutations::Command
  required do
    model :category, new_records: true
  end

  def execute
    category.save!
  end
end
