class BuildNewSubcategory < Mutations::Command
  def execute
    Subcategory.new
  end
end
