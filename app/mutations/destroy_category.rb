class DestroyCategory < Mutations::Command
  required do
    model :category
  end

  def execute
    category.destroy!
  end
end
